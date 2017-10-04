(define (domain shakey)
  ; The domain is a representation of Shakey
  ; and how he can interact with the surrounding world.
   (:requirements
       :strips
    )
   (:predicates (room ?r) ; r: room
		(gripper ?g) ; g: gripper
		(at-shakey ?r) ; r: room - Is Shakey in the room r?
		(at ?o ?r) ; o: object, r: room - Is the object o in room r?
		(free ?g) ; g: gripper - Is the gripper g free?
		(door ?d) ; d: door
		(wide ?d) ; d: door - Is the door d wide?
		(small-object ?o) ; o: object - Is the object o small?
		(carry ?o ?g) ; o:object, g: gripper  - Is shakey carrying object o with the gripper g?
		(box ?b) ; b: box
		(lightswitch ?l) ; l: lightswitch
		(door-between ?d ?ra ?rb) ; d: door, ra: room-a, rb: room-b
		                          ; - Is there a door d between room ra and room rb?
		(lightswitch-on ?s) ; s: switch - Is lightswitch s turned on?
		
   )
   
   (:action move
       ; This is used to move Shakey between rooms (provided that there is a door).
       :parameters  (?from ?to ?door)
       :precondition (and  (room ?from) (room ?to) (door ?door) (door-between ?door ?from ?to) (at-shakey ?from))
       :effect (and  (at-shakey ?to)
		     (not (at-shakey ?from))))

   (:action pick
       ; Shakey can pick up small objects with a free gripper.
       :parameters (?obj ?room ?gripper ?switch)
       :precondition  (and  (small-object ?obj) (room ?room) (gripper ?gripper) (lightswitch ?switch) 
       		      (lightswitch-on ?switch) (at ?switch ?room)
			    (at ?obj ?room) (at-shakey ?room) (free ?gripper))
       :effect (and (carry ?obj ?gripper)
		    (not (at ?obj ?room)) 
		    (not (free ?gripper))))

   (:action drop
       ; Shakey can drop objects he is holding with a gripper.
       :parameters  (?obj ?room ?gripper)
       :precondition  (and  (small-object ?obj) (room ?room) (gripper ?gripper)
			    (carry ?obj ?gripper) (at-shakey ?room))
       :effect (and (at ?obj ?room)
		    (free ?gripper)
		    (not (carry ?obj ?gripper))))

   (:action push
       ; Shakey can push a large box between rooms provided there is a wide door.
       :parameters (?from ?to ?box ?door)
       :precondition (and (box ?box) (at ?box ?from) (room ?from) (room ?to)
			  (at-shakey ?from) (door ?door) (wide ?door) (door-between ?door ?from ?to)
		     )
       :effect(and (at-shakey ?to) (at ?box ?to) (not(at-shakey ?from)) (not(at ?box ?from)))
   )
		      
   (:action turn_light_on
       ; Shakey can turn on a light with a free gripper.
       :parameters (?room ?box ?switch ?gripper)
       :precondition (and (box ?box) (at ?box ?room) (room ?room) (at-shakey ?room)
			  (gripper ?gripper) (free ?gripper)
			  (lightswitch ?switch) (at ?switch ?room)
			  (not (lightswitch-on ?switch))
		     )
       :effect(lightswitch-on ?switch)
   )

   (:action turn_light_off
       ; Shakey can turn off a light with a free gripper.
       :parameters (?room ?box ?switch ?gripper)
       :precondition (and (box ?box) (at ?box ?room) (room ?room) (at-shakey ?room)
			  (gripper ?gripper) (free ?gripper)
			  (lightswitch ?switch) (at ?switch ?room)
			  (lightswitch-on ?switch)
		     )
       :effect(not (lightswitch-on ?switch))
   )
)