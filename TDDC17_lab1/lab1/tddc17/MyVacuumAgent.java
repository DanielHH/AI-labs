package tddc17;


import aima.core.environment.liuvacuum.*;
import aima.core.agent.Action;
import aima.core.agent.AgentProgram;
import aima.core.agent.Percept;
import aima.core.agent.impl.*;

import java.util.Random;

class MyAgentState
{
    public int[][] world = new int[30][30];
    public int initialized = 0;
    final int UNKNOWN 	= 0;
    final int WALL 		= 1;
    final int CLEAR 	= 2;
    final int DIRT		= 3;
    final int HOME		= 4;
    final int ACTION_NONE 			= 0;
    final int ACTION_MOVE_FORWARD 	= 1;
    final int ACTION_TURN_RIGHT 	= 2;
    final int ACTION_TURN_LEFT 		= 3;
    final int ACTION_SUCK	 		= 4;

    public int agent_x_position = 1;
    public int agent_y_position = 1;
    public int agent_last_action = ACTION_NONE;

    public static final int NORTH = 0;
    public static final int EAST = 1;
    public static final int SOUTH = 2;
    public static final int WEST = 3;
    public int agent_direction = EAST;

    MyAgentState()
    {
	for (int i=0; i < world.length; i++)
	    for (int j=0; j < world[i].length ; j++)
		world[i][j] = UNKNOWN;
	world[1][1] = HOME;
	agent_last_action = ACTION_NONE;
    }
    // Based on the last action and the received percept updates the x & y agent position
    public void updatePosition(DynamicPercept p)
    {
	Boolean bump = (Boolean)p.getAttribute("bump");

	if (agent_last_action==ACTION_MOVE_FORWARD && !bump)
	{
	    switch (agent_direction) {
		case MyAgentState.NORTH:
		    agent_y_position--;
		    break;
		case MyAgentState.EAST:
		    agent_x_position++;
		    break;
		case MyAgentState.SOUTH:
		    agent_y_position++;
		    break;
		case MyAgentState.WEST:
		    agent_x_position--;
		    break;
	    }
	}

    }

    public void updateWorld(int x_position, int y_position, int info)
    {
	world[x_position][y_position] = info;
    }

    public void printWorldDebug()
    {
	for (int i=0; i < world.length; i++)
	{
	    for (int j=0; j < world[i].length ; j++)
	    {
		if (world[j][i]==UNKNOWN)
		    System.out.print(" ? ");
		if (world[j][i]==WALL)
		    System.out.print(" # ");
		if (world[j][i]==CLEAR)
		    System.out.print(" . ");
		if (world[j][i]==DIRT)
		    System.out.print(" D ");
		if (world[j][i]==HOME)
		    System.out.print(" H ");
	    }
	    System.out.println("");
	}
    }
}

class MyAgentProgram implements AgentProgram {

    private boolean north_blocked = false;
    private boolean west_blocked = false;
    private boolean east_blocked = false;
    private boolean south_blocked = false;
    private boolean south_east_visited = false;
    private boolean north_east_visited = false;
    private boolean south_west_visited = false;
    private boolean every_tile_visited = false;
    private boolean safety_walk = false;
    private boolean left_home = false;

    private int initnialRandomActions = 10;
    private Random random_generator = new Random();
    private int[] last_two_actions = {-1, -1};

    // Here you can define your variables!
    // public int iterationCounter = 5;
    public MyAgentState state = new MyAgentState();

    // moves the Agent to a random start position
    // uses percepts to update the Agent position - only the position, other percepts are ignored
    // returns a random action
    private Action moveToRandomStartPosition(DynamicPercept percept) {
	int action = random_generator.nextInt(6);
	initnialRandomActions--;
	state.updatePosition(percept);
	if(action==0) {
	    state.agent_direction = ((state.agent_direction-1) % 4);
	    if (state.agent_direction<0)
		state.agent_direction +=4;
	    state.agent_last_action = state.ACTION_TURN_LEFT;
	    return LIUVacuumEnvironment.ACTION_TURN_LEFT;
	} else if (action==1) {
	    return turnRight();
	}
	state.agent_last_action=state.ACTION_MOVE_FORWARD;
	return LIUVacuumEnvironment.ACTION_MOVE_FORWARD;
    }


    @Override
    public Action execute(Percept percept) {

	// DO NOT REMOVE this if condition!!!
	if (initnialRandomActions>0) {
	    return moveToRandomStartPosition((DynamicPercept) percept);
	} else if (initnialRandomActions==0) {
	    // process percept for the last step of the initial random actions
	    initnialRandomActions--;
	    state.updatePosition((DynamicPercept) percept);
	    System.out.println("Processing percepts after the last execution of moveToRandomStartPosition()");
	    state.agent_last_action=state.ACTION_SUCK;
	    return LIUVacuumEnvironment.ACTION_SUCK;
	}

	// This example agent program will update the internal agent state while only moving forward.
	// START HERE - code below should be modified!

	System.out.println("x=" + state.agent_x_position);
	System.out.println("y=" + state.agent_y_position);
	System.out.println("dir=" + state.agent_direction);

	DynamicPercept p = (DynamicPercept) percept;
	Boolean bump = (Boolean)p.getAttribute("bump");
	Boolean dirt = (Boolean)p.getAttribute("dirt");
	Boolean home = (Boolean)p.getAttribute("home");
	System.out.println("percept: " + p);

	if (home && left_home) {
	    return NoOpAction.NO_OP;
	}
	else if (safety_walk) {
	    if (bump) {
		switch (state.agent_direction) {
		    case MyAgentState.NORTH:
		    case MyAgentState.EAST:
			return turnLeft();
		    case MyAgentState.SOUTH:
		    case MyAgentState.WEST:
			return turnRight();
		}
	    } else {
		left_home = true;
		return walkForward();
	    }
	} else if (home && south_east_visited) {
	    safety_walk = true;
	    if(state.agent_direction == state.NORTH) {
		return turnRight();
	    }
	    else if(state.agent_direction == state.WEST) {
		return turnLeft();
	    }
	}

	// State update based on the percept value and the last action
	state.updatePosition((DynamicPercept)percept);
	if (bump) {
	    switch (state.agent_direction) {
		case MyAgentState.NORTH:
		    state.updateWorld(state.agent_x_position,state.agent_y_position-1,state.WALL);
		    break;
		case MyAgentState.EAST:
		    state.updateWorld(state.agent_x_position+1,state.agent_y_position,state.WALL);
		    break;
		case MyAgentState.SOUTH:
		    state.updateWorld(state.agent_x_position,state.agent_y_position+1,state.WALL);
		    break;
		case MyAgentState.WEST:
		    state.updateWorld(state.agent_x_position-1,state.agent_y_position,state.WALL);
		    break;
	    }
	}
	if (dirt)
	    state.updateWorld(state.agent_x_position,state.agent_y_position,state.DIRT);
	else
	    state.updateWorld(state.agent_x_position,state.agent_y_position,state.CLEAR);

	state.printWorldDebug();


	// Next action selection based on the percept value
	if (dirt)
	{
	    System.out.println("DIRT -> choosing SUCK action!");
	    state.agent_last_action=state.ACTION_SUCK;
	    return LIUVacuumEnvironment.ACTION_SUCK;
	}
	else
	{
	    if (bump)
	    {
		switch (state.agent_direction) {
		    case MyAgentState.NORTH:
			north_blocked = true;
			break;
		    case MyAgentState.EAST:
			east_blocked = true;
			break;
		    case MyAgentState.SOUTH:
			south_blocked = true;
			break;
		    case MyAgentState.WEST:
			west_blocked = true;
			break;
		}

		switch (state.agent_direction) {
		    case MyAgentState.NORTH:
			if (east_blocked) {
			    north_east_visited = true;
			}
			if (!south_east_visited) {
			    return turnRight();
			} else if (south_east_visited) {
			    state.agent_direction = ((state.agent_direction-1) % 4);
			    if (state.agent_direction<0)
				state.agent_direction +=4;
			    state.agent_last_action = state.ACTION_TURN_LEFT;
			    last_two_actions[0] = last_two_actions[1];
			    last_two_actions[1] = state.ACTION_TURN_LEFT;
			    return LIUVacuumEnvironment.ACTION_TURN_LEFT;
			}
			break;
		    case MyAgentState.EAST:
			if (north_blocked) {
			    north_east_visited = true;
			}
			if (south_blocked) {
			    south_east_visited = true;
			    state.agent_direction = ((state.agent_direction-1) % 4);
			    if (state.agent_direction<0)
				state.agent_direction +=4;
			    state.agent_last_action = state.ACTION_TURN_LEFT;
			    return LIUVacuumEnvironment.ACTION_TURN_LEFT;
			} else if (!south_east_visited) {
			    return turnRight();
			} else if (south_east_visited) {
			    state.agent_direction = ((state.agent_direction-1) % 4);
			    if (state.agent_direction<0)
				state.agent_direction +=4;
			    last_two_actions[0] = last_two_actions[1];
			    last_two_actions[1] = state.ACTION_TURN_LEFT;
			    state.agent_last_action = state.ACTION_TURN_LEFT;
			    return LIUVacuumEnvironment.ACTION_TURN_LEFT;
			}
			break;
		    case MyAgentState.SOUTH:
			if (west_blocked) {
			    south_west_visited = true;
			}
			if (east_blocked) {
			    south_east_visited = true;
			    return turnRight();
			} else if (!south_east_visited) {
			    state.agent_direction = ((state.agent_direction-1) % 4);
			    if (state.agent_direction<0)
				state.agent_direction +=4;
			    state.agent_last_action = state.ACTION_TURN_LEFT;
			    return LIUVacuumEnvironment.ACTION_TURN_LEFT;
			} else if (south_east_visited) {
			    return turnRight();
			}
			break;
		    case MyAgentState.WEST:
			if (south_blocked) {
			    south_west_visited = true;
			}
			if (!south_east_visited) {
			    state.agent_direction = ((state.agent_direction-1) % 4);
			    if (state.agent_direction<0)
				state.agent_direction +=4;
			    state.agent_last_action = state.ACTION_TURN_LEFT;
			    return LIUVacuumEnvironment.ACTION_TURN_LEFT;
			} else if (south_east_visited) {
			    return turnRight();
			}
			break;
		}
		System.out.println("missed bump case");
		return NoOpAction.NO_OP;
	    }
	    else {
		if (south_east_visited) {
		    if (last_two_actions[0] == state.ACTION_TURN_RIGHT && last_two_actions[1] == state.ACTION_MOVE_FORWARD && (west_blocked || south_blocked) && (north_east_visited || south_west_visited)) {
			return turnRight();

		    } else if (last_two_actions[0] == state.ACTION_TURN_LEFT && last_two_actions[1] == state.ACTION_MOVE_FORWARD && (east_blocked || north_blocked) && (north_east_visited || south_west_visited)) {
			return turnLeft();
		    }
		}
		switch (state.agent_direction) {
		    case MyAgentState.NORTH:
			south_blocked = false;
			break;
		    case MyAgentState.EAST:
			west_blocked = false;
			break;
		    case MyAgentState.SOUTH:
			north_blocked = false;
			break;
		    case MyAgentState.WEST:
			east_blocked = false;
			break;
		}
		return walkForward();
	    }
	}
    }
    private Action turnRight() {
	state.agent_direction = ((state.agent_direction+1) % 4);
	last_two_actions[0] = last_two_actions[1];
	last_two_actions[1] = state.ACTION_TURN_RIGHT;
	state.agent_last_action = state.ACTION_TURN_RIGHT;
	return LIUVacuumEnvironment.ACTION_TURN_RIGHT;
    }

    private Action turnLeft() {
	state.agent_direction = ((state.agent_direction-1) % 4);
	if (state.agent_direction<0)
	    state.agent_direction +=4;
	last_two_actions[0] = last_two_actions[1];
	last_two_actions[1] = state.ACTION_TURN_LEFT;
	state.agent_last_action = state.ACTION_TURN_LEFT;
	return LIUVacuumEnvironment.ACTION_TURN_LEFT;
    }

    private Action walkForward() {
	last_two_actions[0] = last_two_actions[1];
	last_two_actions[1] = state.ACTION_MOVE_FORWARD;
	state.agent_last_action=state.ACTION_MOVE_FORWARD;
	return LIUVacuumEnvironment.ACTION_MOVE_FORWARD;
    }
}


public class MyVacuumAgent extends AbstractAgent {
    public MyVacuumAgent() {
	super(new MyAgentProgram());
    }
}
