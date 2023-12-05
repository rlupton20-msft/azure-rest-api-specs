import "./Processor.tsp";

@doc("Information regarding the processors of the server")
model ProcessorCollection {
    @doc("Processor count total")
    processorCount: int32;

    @doc("Logical core count")
    logicalProcessorCount: int32;

    @doc("The processors of the server")
    processors: Processor[];
}