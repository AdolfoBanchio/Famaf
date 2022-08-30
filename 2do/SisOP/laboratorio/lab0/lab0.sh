#ejercicio 1
grep "model name" /proc/cpuinfo -m 1

#ejercicio 2
grep "model name" /proc/cpuinfo | wc -l
#ejercicio 3
wget https://www.gutenberg.org/files/11/11-0.txt && sed 's/Alice/Adolfo/g' 11-0.txt > ADOLFO_in_wonderland.txt && rm 11-0.txt

#ejercicio 4
#temperatura maxima
sort -k 5 -n weather_cordoba.in | tail -n 1

#temperatura minima
sort -k 6 -n weather_cordoba.in | head -n 1 

#ejercicio 5
sort -k 3 -n atpplayers.in 

#ejercicio 6
awk 'dif=$7-$8 {print $0, dif}' superliga.in | sort -k 2 -k 9 -n -r

#ejercicio 7
ip link | grep 'link/ether' -i

#ejercicio 8
#crea la carpeta y los archivos
mkdir Vikings && for i in {1..10}; do touch Vikings/vik_S01E"$i"_es.srt ; done

#modifica el nombre de los archivos
for f in *_es.srt ; do mv -- "$f" "${f%_es.srt}.srt"; done
