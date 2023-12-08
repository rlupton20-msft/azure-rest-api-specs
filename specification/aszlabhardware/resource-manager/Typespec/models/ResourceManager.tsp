@doc("The status of the resource manager.")
enum ResourceManagerStatus {
    @doc("The resource is being created.")
    Creating,

    @doc("The resource is being converged.")
    Converging,

    @doc("The resource is converged.")
    Converged,

    @doc("The resource is being deleted.")
    Deleting,

    @doc("The resource failed to create.")
    FailedToCreate,

    @doc("The resource failed to converge.")
    FailedToConverge,

    @doc("The resource failed to delete.")
    FailedToDelete
}

@doc("The properties of the resource manager.")
model ResourceManager {
    @doc("The current status of the ResourceManager")
    status: ResourceManagerStatus;

    @doc("The error message of the ResourceManager (if in failed state)")
    errorMessage?: string;
}
