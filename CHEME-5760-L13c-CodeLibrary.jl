abstract type AbstractWorldModel end
abstract type AbstractAgentModel end

mutable struct MyCubicGridWorldModel <: AbstractWorldModel

    # data -
    dimensions::Dict{Int,Int}
    coordinates::Dict{Int,Tuple{Int,Int,Int}}
    states::Dict{Tuple{Int,Int,Int},Int}
    moves::Dict{Int,Tuple{Int,Int,Int}}
    rewards::Dict{Int,Float64}

    # constructor -
    MyCubicGridWorldModel() = new();
end

mutable struct MyQLearningAgentModel <: AbstractAgentModel

    # data -
    states::Array{Int,1}
    actions::Array{Int,1}
    γ::Float64
    α::Float64 
    Q::Array{Float64,2}

    # constructor
    MyQLearningAgentModel() = new();
end

function build(modeltype::Type{MyCubicGridWorldModel}, data::NamedTuple)::MyCubicGridWorldModel

    # initialize and empty model -
    model = modeltype();

    # get the data -
    dimensions = data[:dimensions]
    rewards = data[:rewards]
    defaultreward = haskey(data, :defaultreward) == false ? 0.0 : data[:defaultreward]

    # setup storage
    rewards_dict = Dict{Int,Float64}()
    coordinates = Dict{Int,Tuple}()
    states = Dict{Tuple{Int,Int,Int},Int}()
    moves = Dict{Int,Tuple{Int,Int,Int}}()

    # get the dimensions -
    nx = dimensions[1]
    ny = dimensions[2]
    nz = dimensions[3]

    # build all the stuff 
    position_index = 1;
    for i ∈ 1:nx
        for j ∈ 1:ny
            for k ∈ 1:nz
                
                # capture this corrdinate 
                coordinate = (i,j,k);

                # set -
                coordinates[position_index] = coordinate;
                states[coordinate] = position_index;

                if (haskey(rewards,coordinate) == true)
                    rewards_dict[position_index] = rewards[coordinate];
                else
                    rewards_dict[position_index] = defaultreward;
                end

                # update position_index -
                position_index += 1;
            end
        end
    end

    # TODO: build the moves -
    moves[1] = (1,0,0); 
    moves[2] = (-1,0,0);
    moves[3] = (0,1,0);
    moves[4] = (0,-1,0);
    moves[5] = (0,0,1);
    moves[6] = (0,0,-1);
    moves[7] = (0,0,0);

    # add items to the model -
    model.rewards = rewards_dict
    model.coordinates = coordinates
    model.states = states;
    model.moves = moves;
    model.dimensions = dimensions;

    # return -
    return model
end

function build(modeltype::Type{MyQLearningAgentModel}, data::NamedTuple)::MyQLearningAgentModel

    # initialize -
    model = MyQLearningAgentModel();

    # if we have options, add them to the contract model -
    if (isempty(data) == false)
    
        for key ∈ fieldnames(modeltype)
            
            # convert the field_name_symbol to a string -
            field_name_string = string(key)

            # check the for the key -
            if (haskey(data, key) == false)
                throw(ArgumentError("NamedTuple is missing: $(field_name_string)"))
            end

            # get the value -
            value = data[key]

            # set -
            setproperty!(model, key, value)
        end
    end

    # return -
    return model
end


"""
    _update!(model::MyQLearningModel, data::NamedTuple) -> MyQLearninAgentModel
"""
function _world(model::MyCubicGridWorldModel, s::Int, a::Int)::Tuple{Int, Float64}

    # initialize -
    s′ = nothing
    r = nothing
    
    # get data from the model -
    coordinates = model.coordinates;
    moves = model.moves
    states = model.states;
    rewards = model.rewards;

    # where are we now?
    current_position = coordinates[s];

    # get the perturbation -
    Δ = moves[a];
    new_position = current_position .+ Δ

    # before we go on, have we "driven off the grid"?
    if (haskey(states, new_position) == true)

        # lookup the new state -
        s′ = states[new_position];
        r = rewards[s′];
    else
       
        # ok: so we are all the grid. Bounce us back to to the current_position, and charge a huge penalty 
        s′ = states[current_position];
        r = -1000000000000.0
    end

    # return -
    return (s′,r);
end

"""
    _update!(model::MyQLearningModel, data::NamedTuple) -> MyQLearningAgentModel
"""
function _update(model::MyQLearningAgentModel, data::NamedTuple)::MyQLearningAgentModel

    # grab the s,a,reward and next state from the data tuple
    s = data[:s];
    a = data[:a];
    r = data[:r];
    s′ = data[:s′];
    

    # grab parameters from the model -
    γ, Q, α = model.γ, model.Q, model.α

    # use the update rule to update Q -
    Q[s,a] += α*(r+γ*maximum(Q[s′,:]) - Q[s,a])

    # return -
    return model;
end

# Cool hack: What is going on with these?
(model::MyCubicGridWorldModel)(s::Int,a::Int) = _world(model, s, a);
(model::MyQLearningAgentModel)(data::NamedTuple) = _update(model, data);

"""
    simulate(model::MyQLearningModel, environment::T, startstate::Int, maxsteps::Int;
        ϵ::Float64 = 0.2) -> MyQLearningModel where T <: AbstractWorldModel
"""
function simulate(agent::MyQLearningAgentModel, environment::T, startstate::Tuple{Int,Int,Int}, 
    maxsteps::Int; ϵ::Float64 = 0.2)::MyQLearningAgentModel where T <: AbstractWorldModel

    # initialize -
    s = environment.states[startstate]
    actions = agent.actions;
    number_of_actions = length(actions);

    # simulation loop -
    for _ ∈ 1:maxsteps

        a = nothing;
        if rand() < ϵ

            # we generate a random action
            a = rand(1:number_of_actions);
        else

            # ok: so we are in some state s, let's use our memory to suggest a new action
            Q = agent.Q;
            a = argmax(Q[s,:]);
        end

        # check the action -
        s′, r = nothing, nothing;
        current_position = environment.coordinates[s];
        new_position = current_position .+ environment.moves[a]
        if (haskey(environment.states, new_position) == true)

            # ask the world, what is my next state and reward from this (s,a)
            (s′,r) = environment(s,a)
        else
            s′ = s;
            r = -1000000000000.0;
        end
        
        # update my model -
        agent = agent((
            s = s, a = a, r = r, s′ = s′
        ));

        # move -
        s = s′;
    end

    # return -
    return agent
end


function policy(Q_array::Array{Float64,2})::Array{Int64,1}

    # get the dimension -
    (NR, _) = size(Q_array);

    # initialize some storage -
    π_array = Array{Int64,1}(undef, NR)
    for s ∈ 1:NR
        π_array[s] = argmax(Q_array[s,:]);
    end

    # return -
    return π_array;
end