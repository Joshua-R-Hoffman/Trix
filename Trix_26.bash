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
#   |* ________________________________________Trix-26_|_2/25/2020_____________________________________ *|
#   | /                                                                                                \ |
#   | |                                    Written by: Joshua Hoffman                                  | |
#   | |                                 joshua.hoffman.ray@protonmail.com                              | |
#   | |                                                                                                | |
#   | \_________________________________________A_Thing_Of_Things______________________________________/ |
#   |____________________________________________________________________________________________________|
#
#

Trix () {

unset L
unset M
unset A
A=( $@ )
A_Disp=( ${A[@]} )
B=( 0 0 0 )
C=( {A..Z} )
D=( {1..10} {20..100..10} )
E=( graph print blank punct cntrl digit alnum lower upper alpha )
F=( {a..z} )
G=( exit return break continue echo )
H=( $(awk -F'\}' '/\(\)/ && !/awk/ && !/Trix/ && !/Deck/ {print $0"\n"}' $0 | tr -d [:blank:],\(,\),\{) )
I=( ${B[@]} ${C[@]} ${D[@]} ${E[@]} ${F[@]} ${G[@]} )
	if [[  ${A[0]} = '' ]]; then
	A=( ${A[@]:1} )
		for J in ${K[@]}; do
		export ${J/=*/=''}
		done
	unset K
	fi
	if ! [[ ${A[0]} =~ ^[-] ]] && [[ ${A[@]} != '' ]]; then
	L=( ${I[@]} )
		while ! [[ ${A[0]} =~ ^[-] ]] && [[ -n ${A[@]} ]]; do
		M=( ${M[@]} ${A[0]} ) && A=( ${A[@]:1} )
		done
	elif [[ ${A[0]} =~ ^[-] ]] || [[ ${A[@]} = '' ]]; then
	L=( ${I[@]} ) && M=( ${H[@]} )
	fi
N=$( echo "${A[@]}" | tr [:space:] '\n' | wc -l )
declare -A O
unset P
Q=0
	for R in ${M[@]}; do
	unset P
	((Q++))
		for S in ${L[@]}; do
		((P++))
			if [[ ${S} = 0 ]] && [[ ${P} -le 3 ]]; then
			eval O[-B${P}]+=${R}_B${P}=\${${R}_B${P}:=${S}\ }
			elif [[ ${S} =~ ^[1-9] ]] && [[ ${P} -ge 3 ]]; then
			eval O[-N${S}]+=${R}_${S}=\${${R}_${S}:=${S}\ }
			elif [[ ${S} =~ ^[Aa-Zz] ]] && [[ ${#S} = 1 ]]; then
			eval O[-${S}]+=${R}_${S}=\${${R}_${S}:=${S}\ }
			elif [[ ${S} =~ ^[Aa-Zz] ]] && [[ ${#S} -gt 1 ]]; then
			eval O[-${S}]+=${R}_${S}=\${${R}_${S}:=${S}\ }
			fi
		done
	unset T
	declare -A U
	declare -A V
		if [[ $W != 1 ]]; then
				for X in ${A[@]}; do
				((T++))
				if [[ $N -lt $T ]]; then
				W=1 && break
				elif [[ -z ${O[$X]} ]] && (( $T % 2 )); then
				unset && exit 1
				elif [[ -n ${O[$X]} ]]; then
				Y=$X
				else
				eval U[$Y]+=\${O[$Y]/=*/=$X\ }
				eval V[$Y]+="\${O[$Y]}\ "
				O[$Y]=
					if [[ $Q = ${#M[@]} ]]; then
					eval V[$Y]+=\${O[$Y]}
					eval O[$Y]=\"${U[$Y]}\"
					fi
				fi
			done
		fi
	unset P
	unset W
	done
	for Z in ${O[@]}; do
	export ${Z/=*=/=}
	done
K=( ${V[@]} )

}
