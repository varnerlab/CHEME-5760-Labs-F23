struct MyTravelersProblem end

n_agents(simpleGame::Type{MyTravelersProblem}) = 2
ordered_actions(simpleGame::Type{MyTravelersProblem}, i::Int) = 2:100
ordered_joint_actions(simpleGame::Type{MyTravelersProblem}) = vec(collect(Iterators.product([ordered_actions(simpleGame, i) for i in 1:n_agents(simpleGame)]...)))

n_joint_actions(simpleGame::Type{MyTravelersProblem}) = length(ordered_joint_actions(simpleGame))
n_actions(simpleGame::Type{MyTravelersProblem}, i::Int) = length(ordered_actions(simpleGame, i))

function reward(simpleGame::Type{MyTravelersProblem}, i::Int, a)
    if i == 1
        noti = 2
    else
        noti = 1
    end
    if a[i] == a[noti]
        r = a[i]
    elseif a[i] < a[noti]
        r = a[i] + 2
    else
        r = a[noti] - 1
    end
    return r
end

function joint_reward(simpleGame::Type{MyTravelersProblem}, a)
    return [reward(simpleGame, i, a) for i in 1:n_agents(simpleGame)]
end

function build(simpleGameType::Type{MyTravelersProblem})

    # what problem are we trying to solve?
    # simpleGame = simpleGameType();

    # build an empty model -
    model = MySimpleGameModel();
    model.γ = 0.9;
    model.ℐ = vec(collect(1:n_agents(simpleGameType)))
    model.𝒜 = [ordered_actions(simpleGameType, i) for i in 1:n_agents(simpleGameType)]
    model.R = (a) -> joint_reward(simpleGameType, a)

    # return the model -
    return model;
end

function build(𝒫::MySimpleGameModel, k_max)
    π = [MySimpleGamePolicy(ai => 1.0 for ai in 𝒜i) for 𝒜i in 𝒫.𝒜]
    return MyIteratedBestResponsePolicy(k_max, π)
end