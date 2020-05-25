(define (problem cooperation-problem)
	(:domain cooperation)
	(:objects 
		leader - UGV
		follower - UAV
		n0 n1 - navmode
		P_0 P_45 P_90 P_135 P_180 P_225 P_270 P_315 - pan
		T_0 T_45 T_90 T_270 T_315 - tilt  
		P0509 P0610 P1002 P1613 - point
		
		
	)

	(:init
		

		(navigation-mode leader n0)
		(navigation-mode follower n0)


		(uav-base P1002)
		(ugv-base P0610)		
		

		(vehicle-at leader P0610)
		(vehicle-at follower P1002)

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
		(=(duration-change-orientation P_0 P_0 T_90 T_270 ) 2)
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
		(=(energy-change-orientation P_0 P_0 T_90 T_270 ) 4)
		(=(energy-change-orientation P_0 P_0 T_270 T_315 ) 2)
	
		
		(orientation leader P_0 T_0)
		(orientation follower P_0 T_0)
				

		(rotationAllowed P_0 P_0)
		(rotationAllowed P_0 P_45)
		(rotationAllowed P_45 P_45)
		(rotationAllowed P_45 P_90)
		(rotationAllowed P_90 P_90) 
		(rotationAllowed P_90 P_135)
		(rotationAllowed P_135 P_135)
		(rotationAllowed P_135 P_180)
		(rotationAllowed P_180 P_180)
		(rotationAllowed P_180 P_225) 
		(rotationAllowed P_225 P_225)
		(rotationAllowed P_225 P_270)
		(rotationAllowed P_270 P_270)
		(rotationAllowed P_270 P_315)
		(rotationAllowed P_315 P_315) 
		

		(rotationAllowed T_0 T_0)  	
		(rotationAllowed T_0 T_45)
		(rotationAllowed T_45 T_45)	
		(rotationAllowed T_45 T_90)
		(rotationAllowed T_90 T_90)
		(rotationAllowed T_90 T_270)  	
		(rotationAllowed T_270 T_270)
		(rotationAllowed T_270 T_315)
		(rotationAllowed T_315 T_315)


		(docked leader)
		(docked follower)
		
		(=(duration-move P0610 P0509 n0) 8)
		(=(duration-move P0610 P0509 n1) 4)
		
		(=(duration-move P0610 P1613 n0) 26)
		(=(duration-move P0610 P1613 n1) 13)
		
		(=(duration-move P1002 P0509 n0) 24)
		(=(duration-move P1002 P0509 n1) 12)

		(=(duration-move P1002 P1613 n0) 34)
		(=(duration-move P1002 P1613 n1) 17)

		(=(energy-consumed-move P0610 P0509 n0) 3)
		(=(energy-consumed-move P0610 P0509 n1) 2)
		
		(=(energy-consumed-move P0610 P1613 n0) 6)
		(=(energy-consumed-move P0610 P0509 n1) 3)
		
		(=(energy-consumed-move P1002 P0509 n0) 5)
		(=(energy-consumed-move P1002 P0509 n1) 3)

		(=(energy-consumed-move P1002 P1613 n0) 8)
		(=(energy-consumed-move P1002 P1613 n1) 5)

		(=(distance-travelled P0610 P0509) 2)
		(=(distance-travelled P0610 P1613) 13)
		(=(distance-travelled P1002 P0509) 12)
		(=(distance-travelled P1002 P1613) 17)

				
	)

	(:goal (and 	
                    ;(not(docked leader))
		    (picture-taken P0509 P_0 T_0)
		    (picture-taken P1613 P_0 T_0)
		) 

	)

	;A PESAR DE QUE TENGO PUESTAS ESTAS RESTRICCIONES, A SGPLAN PARECE QUE LE DA UN POCO IGUAL, YA QUE SOLO USA AL FOLLOWER

	;(:constraints (and ;(preference uav-out (always (not(vehicle-at follower P1002)) )); CON ESTO DA WARNING DICIENDO QUE NO ENCUENTRA PLAN QUE LO CUMPLA, YA QUE EMPIEZA AHÍ
	;	     	   (preference uav-out (sometime (not(vehicle-at follower P1002)) ))
	;		   (preference ugv-out (sometime (not(vehicle-at leader P0610)) ))
	;		)
	;)

	;ESTO PARECE QUE TAMPOCO LO CUMPLE YA QUE NO PASA AL MODO DE NAVEGACION 1 PARA IR MAS RAPIDO
	;(:metric minimize (+ (mytotal-time)
	;		     (total-energy-consumed)
	;			  (* 4 (is-violated uav-out))
	;			  (* 3 (is-violated ugv-out)) 
	;			)
	;)

	

)
