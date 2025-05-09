(define (domain shakey)
   (:requirements
    :strips
    ; :typing
    )
  ; (:types
   ; door ; there are several doors connecting two different rooms in Shakey's world
    ; room ; several rooms in Shakey's world
    ; light_switch ; In every room there is a light switch which will switch whether the light is on or off in that room
    ; box ; a box can be pushed and climbed by Shakey.
    ; small_object ; object which can be carried by Shakey 
    ; )


   
   (:predicates (room ?r) ; r: room
		(gripper ?g) ; g: gripper
		(at-shakey ?r) ; r: room 
		(at ?o ?r) ; o: object, r: room
		(free ?g) ; g: gripper
		(door ?d) ; d: door
		(wide ?d) ; d: door
		(small-object ?o) ; o: object
		(carry ?o ?g) ; o:object, g: gripper
		(box ?b) ; b: box
		(lightswitch ?l) ; l: light-switch
		(door-between ?d ?ra ?rb) ; d: door, ra: room-a, rb: room-b
		(lightswitch-on ?s) ; s: switch


		(shakey-on-box ?b)
		(box-below-switch ?b ?s) ; b: box, s: switch
		
   )
   
   (:action move
       :parameters  (?from ?to ?door)
       :precondition (and  (room ?from) (room ?to) (door ?door) (door-between ?door ?from ?to) (at-shakey ?from))
       :effect (and  (at-shakey ?to)
		     (not (at-shakey ?from))))

   (:action pick
       :parameters (?obj ?room ?gripper)
       :precondition  (and  (small-object ?obj) (room ?room) (gripper ?gripper)
			    (at ?obj ?room) (at-shakey ?room) (free ?gripper))
       :effect (and (carry ?obj ?gripper)
		    (not (at ?obj ?room)) 
		    (not (free ?gripper))))

   (:action drop
       :parameters  (?obj ?room ?gripper)
       :precondition  (and  (small-object ?obj) (room ?room) (gripper ?gripper)
			    (carry ?obj ?gripper) (at-shakey ?room))
       :effect (and (at ?obj ?room)
		    (free ?gripper)
		    (not (carry ?obj ?gripper))))

   (:action push
       :parameters (?from ?to ?box ?door)
       :precondition (and (box ?box) (at ?box ?from) (room ?from) (room ?to)
			  (at-shakey ?from) (door ?door) (wide ?door) (door-between ?door ?from ?to)
		     )
       :effect(and (at-shakey ?to) (at ?box ?to) (not(at-shakey ?from)) (not(at ?box ?from)))
   )
		      
   (:action turn_light_on
       :parameters (?room ?box ?switch)
       :precondition (and (box ?box) (at ?box ?room) (room ?room) (at-shakey ?room)
			  (lightswitch ?switch) (at ?switch ?room)
			  (not (lightswitch-on ?switch))
		     )
       :effect(lightswitch-on ?switch)
   )
)