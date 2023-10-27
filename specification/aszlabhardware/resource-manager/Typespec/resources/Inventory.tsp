import "../main.tsp";
import "./AszLabHardwareSystem.tsp";

@doc("Details of the physical properties of the AszLabHw Server")
model Inventory {
    @doc("The processor of the Server")
    systems: AszLabHardwareSystem[];
}