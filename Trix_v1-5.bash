#!/bin/bash
#
#    ____________________________________________________________________________________________________
#   |* ___________________________________________GPL-3_Licence________________________________________ *|
#   | /                                                                                                \ |
#   | |         This program is free software: you can redistribute it and/or modify                   | |
#   | |         it under the terms of the GNU General Public License as published by                   | |
#   | |         the Free Software Foundation, either version 3 of the License, or                      | |
#   | |         (at your option) any later version.                                                    | |
#   | |                                                                                                | |
#   | |         This program is distributed in the hope that it will be useful,                        | |
#   | |         but WITHOUT ANY WARRANTY; without even the implied warranty of                         | |
#   | |         MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the                          | |
#   | |         GNU General Public License for more details.                                           | |
#   | |                                                                                                | |
#   | |         You should have received a copy of the GNU General Public License                      | |
#   | |         along with this program.  If not, see <http://www.gnu.org/licenses/>.                  | |
#   | |                                                                                                | |
#   | \________________________________________________________________________________________________/ |
#   |* ________________________________________Trix-v1.5_2/25/2020_____________________________________ *|
#   | /                                                                                                \ |
#   | |                                    Written by: Joshua Hoffman                                  | |
#   | |                                 joshua.r.hoffman@protonmail.com                                | |
#   | |                                                                                                | |
#   | \_________________________________________A_Thing_Of_Things______________________________________/ |
#   |____________________________________________________________________________________________________|
#
#

Break="|================================================[0[$(date +'%S_%N' | cut -b 1-5)]0]=========================================|"
ExtArguments=( $@ )

Trix () {

unset Variables
unset Sets
unset A

((Runs++))
Break="|================================================[$Runs[$(date +'%S_%N' | cut -b 1-5)]$Runs]=========================================|"
A=( $@ )
A_Disp=( ${A[@]} )
B=( 0 0 0 )
Upper=( {A..Z} )
Numbers=( {1..10} {20..100..10} )
Classes=( graph print blank punct cntrl digit alnum lower upper alpha )
Lower=( {a..z} )
Express=( exit return break continue echo )
Functions=( $(awk -F'\}' '/\(\)/ && !/awk/ && !/Trix/ && !/Deck/ {print $0"\n"}' $0 | tr -d [:blank:],\(,\),\{) )
Pickup=( ${B[@]} ${Upper[@]} ${Numbers[@]} ${Classes[@]} ${Lower[@]} ${Express[@]} )


	if [[  ${A[0]} = '' ]]; then
	A=( ${A[@]:1} )
	
		for Bridge in ${Discard[@]}; do
		export ${Bridge/=*/=''}
		done
		
	unset Discard
	fi
		
	if ! [[ ${A[0]} =~ ^[-] ]] && [[ ${A[@]} != '' ]]; then
	Variables=( ${Pickup[@]} )
	
	
		while ! [[ ${A[0]} =~ ^[-] ]] && [[ -n ${A[@]} ]]; do
		Sets=( ${Sets[@]} ${A[0]} )
		A=( ${A[@]:1} )
		done

	elif [[ ${A[0]} =~ ^[-] ]] || [[ ${A[@]} = '' ]]; then
	Variables=( ${Pickup[@]} )
	Sets=( ${Functions[@]} )
	
		if [[ -n ${A[@]} ]]; then
		unset Card[@]
		fi
	
	fi

Position=$( echo "${A[@]}" | tr [:space:] '\n' | wc -l )
declare -A Card
unset Turn
Round=0

	for Hands in ${Sets[@]}; do
	unset Turn
	((Round++))
	
		for Play in ${Variables[@]}; do
		((Turn++))

			if [[ ${Play} = 0 ]] && [[ ${Turn} -le 3 ]]; then
			eval Card[-B${Turn}]+=${Hands}_B${Turn}=\${${Hands}_B${Turn}:=${Play}\ }
			elif [[ ${Play} =~ ^[1-9] ]] && [[ ${Turn} -ge 3 ]]; then
			eval Card[-N${Play}]+=${Hands}_${Play}=\${${Hands}_${Play}:=${Play}\ }
			elif [[ ${Play} =~ ^[Aa-Zz] ]] && [[ ${#Play} = 1 ]]; then
			eval Card[-${Play}]+=${Hands}_${Play}=\${${Hands}_${Play}:=${Play}\ }
			elif [[ ${Play} =~ ^[Aa-Zz] ]] && [[ ${#Play} -gt 1 ]]; then
			eval Card[-${Play}]+=${Hands}_${Play}=\${${Hands}_${Play}:=${Play}\ }
			fi

		done
		
	unset Rotation
	declare -A Anti
	declare -A Bluff
	
		if [[ $Bust != 1 ]]; then
	
			for Bet in ${A[@]}; do
			((Rotation++))

				if [[ $Position -lt $Rotation ]]; then
				Bust=1 && break
				elif [[ -z ${Card[$Bet]} ]] && (( $Rotation % 2 )); then
				unset && exit 1
				elif [[ -n ${Card[$Bet]} ]]; then
				Call=$Bet
				else
				eval Anti[$Call]+=\${Card[$Call]/=*/=$Bet\ }
				eval Bluff[$Call]+="\${Card[$Call]}\ "
				Card[$Call]=
				
					if [[ $Round = ${#Sets[@]} ]]; then
					eval Bluff[$Call]+=\${Card[$Call]}
					eval Card[$Call]=\"${Anti[$Call]}\"
					fi
					
				fi
				
			done
			
		fi
		
	unset Turn
	unset Bust
	done
	
	for House in ${Card[@]}; do
	export ${House/=*=/=}
	done

unset Shuffle
Discard=( ${Bluff[@]} )

}

#Example usage

Foo () {

((Count++))
echo -e "| $Count | Trix: ${A_Disp[@]:-None} "
echo -e "${Break^}"
echo -e "| Name: Foo_B1 Var value: ${Foo_B1:-Unset_One}"
echo -e "| Name: Foo_B2 Var value: ${Foo_B2:-Unset_Two}"
echo -e "| Name: Foo_B3 Var value: ${Foo_B3:-Unset_Three}"
echo -e "${Break^}"

}

Bar () {

((Count++))
echo -e "| $Count | Trix: ${A_Disp[@]:-None}"
echo -e "${Break^}"
echo -e "| Name: Bar_B1 Var value: ${Bar_B1:-Unset_Four}"
echo -e "| Name: Bar_B2 Var value: ${Bar_B2:-Unset_Five}"
echo -e "| Name: Bar_B3 Var value: ${Bar_B3:-Unset_Six}"
echo -e "${Break^}"

}

Baz () {

((Count++))
echo -e "| $Count | Trix: ${A_Disp[@]:-None}"
echo -e "${Break^}"
echo -e "| Name: Baz_B1 Var value: ${Baz_B1:-Unset_Seven}"
echo -e "| Name: Baz_B2 Var value: ${Baz_B2:-Unset_Eight}"
echo -e "| Name: Baz_B3 Var value: ${Baz_B3:-Unset_Nine}"
echo -e "${Break^}"

}

Bak () {

((Count++))
echo -e "| $Count | Trix: ${A_Disp[@]:-None}"
echo -e "${Break^}"
echo -e "| Name: Bak_A Var value: ${Bak_A:-A}"
echo -e "| Name: Bak_B Var value: ${Bak_B:-B}"
echo -e "| Name: Bak_C Var value: ${Bak_C:-C}"
echo -e "| Name: Bak_1 Var value: ${Bak_1:-1}"
echo -e "| Name: Bak_2 Var value: ${Bak_2:-2}"
echo -e "| Name: Bak_3 Var value: ${Bak_3:-3}"
echo -e "${Break^}"

}

echo ${Break^}
Foo && Bar && Baz
Trix
Foo && Bar && Baz
Trix Foo -B1 Red -B2 Orange -B3 Yellow
Foo && Bar && Baz
Trix Bar -B1 Green -B2 Blue -B3 Purple
Foo && Bar && Baz
Trix Baz -B1 Violt -B2 Maroon -B3 Indigo
Foo && Bar && Baz
Trix -B1 $(cat /proc/sys/kernel/random/uuid | cut -d - -f 2) -B2 $(cat /proc/sys/kernel/random/uuid | cut -d - -f 2) -B3 $(cat /proc/sys/kernel/random/uuid | cut -d - -f 2)
Foo && Bar && Baz
Trix
Foo && Bar && Baz
Trix -B1 \"\" -B2 \"\" -B3 \"\"
Foo && Bar && Baz
Trix Bak -A $(uname -r) -B $(uname) -C $(whoami) -N1 "$(cat /proc/uptime | awk  '{print $2/3600}')" -N2 "$(date | awk '{print $5}')" -N3 "$(date +'%m-%d-%y')"
Bak
Trix Bak -A '$0' -B 'Created-By: ' -C Joshua -N1 Ray -N2 Hoffman -N3 "joshua.r.hoffman@protonmail.com "
Bak