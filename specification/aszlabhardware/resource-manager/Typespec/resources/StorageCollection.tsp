import "./Drive.tsp";

@doc("Information regarding the storage of the server")
model StorageCollection {
    @doc("Number of disk drives")
    totalDriveCount?: int32;

    @doc("Information about individual disk drives")
    drives?: Drive[];
}