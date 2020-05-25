
(define (domain cooperation)
	(:requirements :strips :typing :conditional-effects :equality :constraints :durative-actions :fluents :adl :preferences)
	(:types UAV UGV - vehicle point navmode Orient pan tilt - orient)

	(:predicates
		(docked ?vehicle)
		(vehicle-at ?vehicle ?point)
		(orientation ?vehicle ?pan ?tilt)
		(navigation-mode ?vehicle ?navmode)
		(picture-taken ?point ?pan ?tilt)
		(picture-transmitted ?point ?pan ?tilt)
		(uav-base ?point)
		(ugv-base ?point)
		(free ?v)
		(rotationAllowed ?o1 ?o2 - Orient)

	)

	(:functions

		(mytotal-time)
		(total-energy-consumed)
		(total-distance-travelled)
		(duration-move ?point ?point ?navmode)
		(energy-consumed-move ?point ?point ?navmode)
		(duration-change-orientation ?pan ?pan ?tilt ?tilt)
		(energy-change-orientation ?pan ?pan ?tilt ?tilt)
		(distance-travelled ?point ?point)
		
		
	)

	
	(:durative-action move
		:parameters (?v - vehicle ?point1 ?point2 - point ?nav - navmode)
		:duration (= ?duration (duration-move ?point1 ?point2 ?nav))
		:condition (and (at start(vehicle-at ?v ?point1))
				(over all (navigation-mode ?v ?nav))
				(over all (free ?v))
			   )
		:effect (and (at start (not (free ?v)))
			     (at end (free ?v)) 
			     (at end (not (vehicle-at ?v ?point1)))
			     (at end (vehicle-at ?v ?point2))
			     (at end (increase (mytotal-time) (duration-move ?point1 ?point2 ?nav) ))
			     (at end (increase (total-energy-consumed) (energy-consumed-move ?point1 ?point2 ?nav) ))
			     (at end (increase (total-distance-travelled) (distance-travelled ?point1 ?point2) ))
			)

	)
	

	(:durative-action change-orientation
		:parameters (?v - vehicle ?p1 ?p2 - pan ?t1 ?t2 - tilt)
		:duration (= ?duration (duration-change-orientation ?p1 ?p2 ?t1 ?t2))
		:condition (and (at start (orientation ?v ?p1 ?t1))
			   (at start (rotationAllowed ?p1 ?p2))
			   (at start (rotationAllowed ?t1 ?t2))
			   (over all (free ?v))
			)
		:effect (and (at end (not(orientation ?v ?p1 ?t1))) 
				(at end (orientation ?v ?p2 ?t2))
                 		(at end (free ?v))
                		(at start (not (free ?v)))
				(at end (increase (mytotal-time) (duration-change-orientation ?p1 ?p2 ?t1 ?t2)))
				
			(at end (increase (total-energy-consumed) (energy-change-orientation ?p1 ?p2 ?t1 ?t2))))
	)



	(:durative-action dock-uav
		:parameters (?uav - vehicle ?point - point)
		:duration (= ?duration 2)
		:condition (and (over all (vehicle-at ?uav ?point)) 
                                (over all (uav-base ?point)) 
                                (at start (free ?uav)) 
                           )
		:effect (and (at end (docked ?uav)) 
			     (at end (not(free ?uav)))	
                             (at end (increase (mytotal-time) 2))
                             (at end (increase (total-energy-consumed) 1)))

	)
	
	(:durative-action dock-uav
		:parameters (?ugv - vehicle ?point - point)
		:duration (= ?duration 2)
		:condition (and (over all (vehicle-at ?ugv ?point)) 
                                (over all (ugv-base ?point)) 
                                (at start (free ?ugv)) 
                           )
		:effect (and (at end (docked ?ugv)) 
			     (at end (not(free ?ugv)))	
                             (at end (increase (mytotal-time) 2))
                             (at end (increase (total-energy-consumed) 1)))

	)

	(:durative-action undock-uav
		:parameters (?uav - vehicle ?point - point)
		:duration (= ?duration 2)
		:condition (and (at start (docked ?uav))
                                (over all (uav-base ?point)) 
                                
			   )
		:effect (and (at end (free ?uav))
			     (at end (not(docked ?uav)))
			     (at end (increase (mytotal-time) 2))
			     (at end (increase (total-energy-consumed) 1)))

	)

	(:durative-action undock-ugv
		:parameters (?ugv - vehicle ?point - point)
		:duration (= ?duration 2)
		:condition (and (at start (docked ?ugv))
                                (over all (ugv-base ?point)) 
                                
			   )
		:effect (and (at end (free ?ugv))
			     (at end (not(docked ?ugv)))
			     (at end (increase (mytotal-time) 2))
			     (at end (increase (total-energy-consumed) 1)))

	)

	(:durative-action change-navmode
		:parameters (?v - vehicle ?n1 ?n2 - navmode)
		:duration (= ?duration 1)
		:condition (at start (navigation-mode ?v ?n1))
		:effect (and (at end (not (navigation-mode ?v ?n1))) (at end (navigation-mode ?v ?n2)) (at end (increase (mytotal-time) 1)) (at end (increase (total-energy-consumed) 1)))
	)

	(:durative-action take-picture
		:parameters (?v - vehicle ?point - point ?pan - pan ?tilt - tilt)
		:duration (= ?duration 3)
		:condition (and (over all (vehicle-at ?v ?point)) (over all (orientation ?v ?pan ?tilt)) (over all (free ?v)))
		:effect (and (at start (not (free ?v))) (at end (free ?v)) (at end (picture-taken ?point ?pan ?tilt)) (at end (increase (mytotal-time) 3)) (at end (increase (total-energy-consumed) 2)))

	)
		
	(:durative-action transmit-picture
		:parameters (?point - point ?p - pan ?t - tilt)
		:duration (= ?duration 4)
		:condition (over all (picture-taken ?point ?p ?t))
		:effect (and (at end (picture-transmitted ?point ?p ?t)) (at end (increase (mytotal-time) 4)) (at end (increase (total-energy-consumed) 5)))
	)
	
)
