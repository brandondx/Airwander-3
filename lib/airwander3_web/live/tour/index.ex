defmodule Airwander3Web.TourLive.Index do
  use Airwander3Web, :live_view
  use Ecto.Schema

  alias Ecto.Changeset

  embedded_schema do
    field :input_1, :string
    field :input_2, :string
    field :input_3, :string
    field :input_4, :string
  end

  def changeset(schema, attrs \\ %{}) do
    schema
    |> Changeset.cast(attrs, [:input_1, :input_2, :input_3, :input_4])
  end

  @trips [
    %{id: 1, title: "One-Way"},
    %{id: 2, title: "Round-Trip"},
    %{id: 3, title: "Multi-City"},
    %{id: 4, title: "World-Tour"}
  ]

  @impl true

  def mount(_params, _session, socket) do
    changeset =
      %__MODULE__{}
      |> changeset(%{})

    socket =
      socket
      |> assign(:trips, @trips)
      |> assign(:trip, nil)
      |> assign(:count, nil)
      |> assign(:changeset, changeset)

    {:ok, socket}
  end

  @impl true
  def handle_params(params, _url, socket) do
    IO.inspect("heyyyy")
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, _, _params), do: socket

  @impl true
  def handle_event("tour_selected", %{"tour" => ""}, socket) do
    {:noreply, assign(socket, :trip, nil)}
  end

  def handle_event("tour_selected", %{"tour" => "2" = id}, socket) do
    trip = Enum.find(@trips, fn x -> "#{x.id}" == id end)

    changes = socket.assigns.changeset.changes

    socket =
      socket
      |> assign(:changeset, put_input_3(changes, Map.get(changes, :input_1)))
      |> assign(:trip, trip)

     {:noreply, socket}
  end

  def handle_event("tour_selected", %{"tour" => "3" = id}, socket) do
    changes = socket.assigns.changeset.changes
    trip = socket.assigns.trip

   changeset =
    if trip && trip.id == 4 do
      put_input_3(changes, Map.get(changes, :input_3))
    else
      put_input_3(changes, Map.get(changes, ""))
    end

    trip = Enum.find(@trips, fn x -> "#{x.id}" == id end)

    socket =
      socket
      |> assign(:changeset, changeset)
      |> assign(:trip, trip)

    {:noreply, socket}
  end

  def handle_event("tour_selected", %{"tour" => "4" = id}, socket) do
    trip = Enum.find(@trips, fn x -> "#{x.id}" == id end)

    changes = socket.assigns.changeset.changes

    socket =
      socket
      |> assign(:changeset, put_input_4(changes, ""))
      |> assign(:trip, trip)

    {:noreply, socket}
  end

  def handle_event("tour_selected", %{"tour" => id}, socket) do
    trip = Enum.find(@trips, fn x -> "#{x.id}" == id end)

    {:noreply, assign(socket, :trip, trip)}
  end

  def handle_event("validate-tour", %{"_target" => ["index", "input_1"], "index" => index}, socket) do
    %{"input_1" => input_1} = index

    socket =
      if socket.assigns.trip && socket.assigns.trip.title == "Round-Trip" do
        assign(socket, :changeset, changeset(%__MODULE__{}, Map.put(index, "input_3", input_1)))
      else
        assign(socket, :changeset, changeset(%__MODULE__{}, index))
      end

    {:noreply, socket}
  end

  def handle_event("validate-tour", %{"index" => index}, socket) do
    {:noreply, assign(socket, :changeset, changeset(%__MODULE__{}, index))}
  end

  def handle_event("submit-tour", _, socket) do
    socket = put_flash(socket, :info,
      "no event defined yet on submit, please provide the further requirements :smile"
      )

    {:noreply, socket}
  end

  defp put_input_3(changes, input_3_value) do
    changeset(%__MODULE__{}, Map.put(changes, :input_3, input_3_value))
  end

  defp put_input_4(changes, input_4_value) do
    changeset(%__MODULE__{}, Map.put(changes, :input_4, input_4_value))
  end

  defp selected_attr(country, country), do: "selected=\"selected\""
  defp selected_attr(_, _), do: ""
end
