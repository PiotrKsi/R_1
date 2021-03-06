# Wprowadzenie do R
# 
# Dominik Deja
# ddeja@pjwstk.edu.pl
# 
# 09.05.2015
# Update: 18.04.2020



# Plan zajęć:
# 1. Co to jest R?
# 2. Typy zmiennych
# 3. Instrukcje warunkowe
# 4. Pętle
# 5. Funkcje



#1. Co to jest R?

#1.1 R jako kalkulator

2+2

2+2*2

(2+2)*2

2^3

log(10)

log(exp(1))

5%%4

5/4

#Zadanie 2.1
#Odnajdź i użyj funkcje: pierwiastek kwadratowy i wartość bezwzględna
sqrt(9)
abs(-4)

#1.2 Poważniejsze zastosowania

#Własne funkcje
Sieve <- function(n)
{
  n <- as.integer(n)
  if(n > 1e6) stop("Za duże n!")
  primes <- rep(TRUE, n)
  primes[1] <- FALSE
  last.prime <- 2L
  for(i in last.prime:floor(sqrt(n)))
  {
    primes[seq.int(2L*last.prime, n, last.prime)] <- FALSE
    last.prime <- last.prime + min(which(primes[(last.prime+1):n]))
  }
  which(primes)
}

Sieve(1000)

#Ilustrowanie i analiza danych
plot(height ~ weight, data = women)
abline(lm(height ~ weight, data = women), col = "blue")

#Analizy statystyczne
shapiro.test(rnorm(10))
shapiro.test(runif(10))

shapiro.test(rnorm(1000))
shapiro.test(runif(1000))

#I jeszcze więcej!

#1.3 Ale od początku! Od czego zacząć?

#Pomoc w R
help(lm)
?lm
??ll

#Ustalanie i zamiana ścieżki do katalogu roboczego
getwd()
setwd("C:\\")
getwd()

#Obszar roboczy (workspace)
x <- TRUE
y <- 1
z <- "Ala ma kota"
ls()
rm(x)
ls()
#Ostrożnie z poniższą komendą!
rm(list = ls())
gc()

#Jak przypisywać wartości do zmiennych?
#Uważnie!
#"<-" kontra "="
x <- 3
x = 1
exp(x = 2)
?exp
#exp(x <- 20)

FALSE -> x

#Pakiety dodatkowe, czyli to z czego słynie R
install.packages("ggplot2")

library(ggplot2)

ggplot(women, aes(y = height, x = weight)) + 
  geom_point() +
  stat_smooth()

ggplot(diamonds, aes(y = price, x = carat)) +
  geom_point() +
  stat_smooth()

#Zadanie 2.2
#Za pomocą funkcji demo() sprawdź jakie przykły możesz obejrzeć, a następnie odpal wybrany, np. graphics.



#2. Typy zmiennych

#2.1 Skalary

x <- 1
y <- 2

x*y

x*y/(x-y)^2

x == y

1 == 1

1 == 1 | 1 == 0

1 == 1 & 1 == 0

!(1 == 1) | 1 == 0

is.integer(2)
is.integer(integer(2))
is.numeric(2)
is.character(2)

#2.2 Wektory

x <- c(1,2,3)
x <- c("a", "B")
x <- c(1, "a")

1:10

#2.2.1 Pomocne funkcje

x <- sample(1:10, 10)
x
length(x)
rev(x)
unique(x)
sort(x)
sort(x, decreasing = TRUE)
order(x)
x[order(x)]
sum(x)
prod(x)
cumsum(x)
cumprod(x)
diff(x)

all(x > 0)
any(x > 0)

#2.2.2 Kopiowanie wektorów

x <- rep(1:5,3)
x
x <- rep(1:5,1:5)
x
x <- rep(3, 1:5)
x <- rep(c('a','b','c','d','e'), 1:5)
x

#2.2.3 Indeksy

#Dla tych, co mieli już styczność z programowaniem - R numeruje od 1!
x <- 1:30
x[10]
x[2:5]
x[-1]
x[-(1:10)]
x[c(-1,2)]

#Używanie indeksów logicznych
x <- rnorm(30)
x
x > 0

x[x > 0]
x[x > 1 | x < -1]

#Działania na wektorach
x <- 1:10
x + 2
x * 5
x ^ 2

#Zadanie 2.3
#Stwórz wektor będący 5 elementowym ciągiem artmetycznym, gdzie a_0 = 7.5 i r = 3

3 * (0:4) + 7.5
seq(7.5, by=3, length.out=5)
seq(7.5, length.out=5, by=3)
seq(by=3, 7.5, length.out=5)


#Domyślne "wydłużanie" wektorów
x <- 1:10
y <- 1:5

x
c(y, y)

x + y

y <- 1:3

x + y

#2.3 Macierze
x <- matrix(1:10, nrow = 2, ncol = 5, byrow = TRUE)
x
x <- matrix(1:10, nrow = 2, ncol = 5, byrow = FALSE)
x
x <- matrix(1:10, nrow = 2, ncol = 5)
x

x[1:3]
x[1,]
x[,2]

x[1, 1:3]
x[,1]

#Mnożenie macierzy
x <- matrix(1:20, nrow = 4, ncol = 5)
y <- matrix(sample(1:20, 20), nrow = 5, ncol = 4)
x %*% y

x*y
x*x

sqrt(x)
log(x)

#Łączenie macierzy
rbind(x, x)
cbind(x, x)

#Zadanie 2.4
#Stwórz macierz 10x10 z numerami od 1 do 100.
#a)Na podstawie tej macierzy utwórz kolejną, o tym samym wymiarze mówiącą o tym, 
#  czy dana liczba jest podzielna przez 7 (macierz zawierająca tylko wartości TRUE/FALSE). 
#b)Wypisz wszystkie liczby z tej macierzy podzielne przez 7.

x <- matrix(1:100, nrow=10, ncol=10)

x%%7 == 0
x[x%%7 == 0]


for(row in 1:nrow(x)){
  for(col in 1:ncol(x)){
    if (x[row,col]%%7 == 0){
      x[row,col]<-TRUE
    } else {
      x[row,col]<-FALSE
    }
  }
}
x

#2.4 Listy

x <- list(a = c(1,2,3), b = c("Alice", "Bob"), c = TRUE, d = list())

names(x)

#Jak odnaleźć się w liście?
x$a
x[1]
x[[1]]
x[["a"]]
x[[1]][3]


#2.5 Ramki danych (data frames)

data(iris)

head(iris)
tail(iris)
str(iris)

names(iris)

table(iris$Species, round(iris$Petal.Length))


attach(iris)
detach(iris)

#Zadanie 2.5
#Jaka jest średnia długość płatka dla zbioru iris?

#Zadanie 2.6
#Używając funkcji table() sprawdź który gatunek ma najszersze płatki

table(iris$Species, round(iris$Petal.Width))

install.packages('dplyr')
library(dplyr)
iris %>%
  group_by(Species) %>%
  summarize(Mean = mean(Petal.Length, na.rm=TRUE))

#3 Instrukcje warunkowe

#3.1 Dla skalarów

#if warunek do_if_TRUE else do_if_FALSE
if (1 > 0) cat("1 jest większe od 0.\n") else cat("1 jest mniejsze od 0.\n")
if (1 > 0) cat("1 jest większe od 0.\n")

x <- -1
if (x > 0) cat("x jest większy od 0.\n") else cat("x jest mniejszy od 0.\n")

if (0) cat("Prawda!\n") else cat("Fałsz!\n")
if (12) cat("Prawda!\n") else cat("Fałsz!\n")

if (c(-1, 0, 1) > 0) cat("Oj, chyba nic z tego!\n")

if (x < 0 | x > 1) cat("Prawda!\n") else cat("Fałsz!\n")

#Jak poprawnie zapisywać warunki
x <- -1
if (x > 0)
  cat("Prawda!\n")
else
  cat("Fałsz!\n")

if (x > 0) {
  cat("Prawda!\n")
} else {
  cat("Fałsz!\n")
}

#3.2 Dla wektorów
ifelse(1:10 > 5, 1, 0)

#Zadanie 2.7
#Zamień wektor 1:10 w następujący sposób:
#Zwróć wektor o wartościach "a", "b", i "c", gdzie jako "a" oznacz liczby mniejsze od 3,
#"b" liczby od 3 do 7, i "c" liczby większe od 7.



#4. Pętle
#Czyli coś czego unikamy jak ognia

#4.1 FOR

for (i in 1:10) {
  cat(paste(i, "\n"))
}

x <- rep(FALSE, 10)
for (i in 1:10) {
  x[i] <- i*i
}

x <- matrix(1:20, ncol = 5)
for (i in 1:5) {
  print(mean(x[,i]))
}

colMeans(x)


#4.2 WHILE
i <- 0
while (i < 5) {
  print(i)
}

#Ups! Wciśnij przycisk "Stop", lub klawisz "Escape".

i <- 0
while (i < 5) {
  print(i)
  i <- i + 1
}

i <- 0
while (i < 5) {
  i <- i + 1
  print(i)
}



#5. Funkcje
Square <- function(x){
  x*x
}

Square(8)

Squares <- function(x, y){
  c(x*x, y*y)
}

Squares(3,4)

rnorm(10)

rnorm(10, mean = 10, sd = 2)

Square2 <- function(x){
  x*x
  z <- x+2
}

Square2(8)

#Rekurencja!
Fac <- function(n){
  ifelse( (n == 1) || (n == 0), 1, n * Fac(n - 1) )
}
Fac(5)


Fibo <- function(n){
  ifelse( (n == 1) || (n == 0), 1, Fibo(n - 1) + Fibo(n - 2) )
}
Fibo(23)

#Zadanie 2.9
#Napisać funkcję fibonacciego bez uciekania się do rekurencji (sposobów jest kilka).


m1 <- matrix(2^c(1:24), nrow=4, byrow=TRUE)
View(m1)