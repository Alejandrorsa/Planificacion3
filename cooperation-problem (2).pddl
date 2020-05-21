(define (problem cooperation-problem)
	(:domain cooperation)
	(:objects 
		leader - UGV
		follower - UAV
		n0 n1 - navmode
		P_0 P_45 P_90 P_135 P_180 P_225 P_270 P_315 - pan
		T_0 T_45 T_90 T_270 T_315 - tilt 
		x5 x6 x10 x16 - positionx ;deberían estar desde x0 hasta x16( o más si queremos un espacio más grande), pero serían demasiadas distancias para definir
		y2 y9 y10 y13 - positiony ;deberían estar desde y0 hasta y16( o más si queremos un espacio más grande), pero serían demasiadas distancias para definir
	)

	(:init
		
		(=(duration-move x6 x5 y10 y9 n0) 4)
		(=(duration-move x6 x5 y10 y9 n1) 2)
		(=(duration-move x10 x5 y2 y9 n0) 24)
		(=(duration-move x10 x5 y2 y9 n1) 12)
		(=(duration-move x16 x5 y13 y9 n0) 30)
		(=(duration-move x16 x5 y13 y9 n1) 15)

		(=(duration-move x6 x16 y10 y13 n0) 26)
		(=(duration-move x6 x16 y10 y13 n1) 13)
		(=(duration-move x10 x16 y2 y13 n0) 34)
		(=(duration-move x10 x16 y2 y13 n1) 17)
		(=(duration-move x5 x16 y9 y13 n0) 30)
		(=(duration-move x5 x16 y9 y13 n1) 15)

		(=(energy-consumed-move x6 x16 y10 y13 n0) 26)
		(=(energy-consumed-move x6 x16 y10 y13 n1) 13)
		(=(energy-consumed-move x10 x16 y2 y13 n0) 34)
		(=(energy-consumed-move x10 x16 y2 y13 n1) 17)
		(=(energy-consumed-move x5 x16 y9 y13 n0) 30)
		(=(energy-consumed-move x5 x16 y9 y13 n1) 15)
		
		(=(energy-consumed-move x6 x5 y10 y9 n0) 4)
		(=(energy-consumed-move x6 x5 y10 y9 n1) 2)
		(=(energy-consumed-move x10 x5 y2 y9 n0) 24)
		(=(energy-consumed-move x10 x5 y2 y9 n1) 12)
		(=(energy-consumed-move x16 x5 y13 y9 n0) 30)
		(=(energy-consumed-move x16 x5 y13 y9 n1) 15)

		
		(navigation-mode leader n0)
		(navigation-mode follower n0)


		(uav-base x10 y2)
		(ugv-base x6 y10)		
		
		;(not(docked leader))
		;(not(docked follower))

		(vehicle-at leader x6 y10)
		(vehicle-at follower x10 y2)

		(=(mytotal-time)0)
		(=(total-distance-travelled)0)
		(=(total-energy-consumed)0)

		(=(duration-change-orientation P_0 P_45 T_0 T_0 ) 1)
		(=(duration-change-orientation P_45 P_90 T_0 T_0 ) 1)
		(=(duration-change-orientation P_90 P_135 T_0 T_0 ) 1)
		(=(duration-change-orientation P_135 P_180 T_0 T_0 ) 1)
		(=(duration-change-orientation P_180 P_225 T_0 T_0 ) 1)
		(=(duration-change-orientation P_225 P_270 T_0 T_0 ) 1)
		(=(duration-change-orientation P_270 P_315 T_0 T_0 ) 1)
		(=(duration-change-orientation P_0 P_0 T_0 T_45 ) 1)
		(=(duration-change-orientation P_0 P_0 T_45 T_90 ) 1)
		(=(duration-change-orientation P_0 P_0 T_90 T_270 ) 1)
		(=(duration-change-orientation P_0 P_0 T_270 T_315 ) 1)
		
		
		(=(energy-change-orientation P_0 P_45 T_0 T_0 ) 2)
		(=(energy-change-orientation P_45 P_90 T_0 T_0 ) 2)
		(=(energy-change-orientation P_90 P_135 T_0 T_0 ) 2)
		(=(energy-change-orientation P_135 P_180 T_0 T_0 ) 2)
		(=(energy-change-orientation P_180 P_225 T_0 T_0 ) 2)
		(=(energy-change-orientation P_225 P_270 T_0 T_0 ) 2)
		(=(energy-change-orientation P_270 P_315 T_0 T_0 ) 2)
		(=(energy-change-orientation P_0 P_0 T_0 T_45 ) 2)
		(=(energy-change-orientation P_0 P_0 T_45 T_90 ) 2)
		(=(energy-change-orientation P_0 P_0 T_90 T_270 ) 2)
		(=(energy-change-orientation P_0 P_0 T_270 T_315 ) 2)
	


		(=(distance-travelled x6 x5 y10 y9 ) 4)
		(=(distance-travelled x6 x5 y10 y9 ) 2)
		(=(distance-travelled x10 x5 y2 y9 ) 24)
		(=(distance-travelled x10 x5 y2 y9 ) 12)
		(=(distance-travelled x16 x5 y13 y9 ) 30)
		(=(distance-travelled x16 x5 y13 y9 ) 15)

		(=(distance-travelled x6 x16 y10 y13 ) 26)
		(=(distance-travelled x6 x16 y10 y13 ) 13)
		(=(distance-travelled x10 x16 y2 y13 ) 34)
		(=(distance-travelled x10 x16 y2 y13 ) 17)
		(=(distance-travelled x5 x16 y9 y13 ) 30)
		(=(distance-travelled x5 x16 y9 y13 ) 15)
		
		(orientation leader P_0 T_0)
		(orientation follower P_0 T_0)
		
		
;;; Nuevo
(rotationAllowed P_0 P_0)
(rotationAllowed P_0 P_45)
(rotationAllowed P_45 P_45)
(rotationAllowed P_90 P_90) 
(rotationAllowed T_0 T_0)  	
(rotationAllowed T_0 T_45)
(rotationAllowed T_45 T_45)
(rotationAllowed T_90 T_90)
(free leader)
(free follower)
; Añadir todas las que se permitan	
	)

	(:goal (and (orientation leader P_45 T_0)
                    ;(not(docked leader))
		    ;(picture-taken x5 y9 P_0 T_0)
		    ;(picture-taken x16 y13 P_0 T_0)
		) 

	)


	

)
