
export const fetchMilestone = async (user: string, repo: string, id: number ): Promise<Response> => {
    let data = await fetch( "https://api.github.com/repos/{user}/{repo}/milestones/{id}" ) 
    return data
}
