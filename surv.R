sexp <- function(q, rate = 1) {
  pexp(q, rate, lower.tail = FALSE)
}

sweibull <- function(q, shape, scale = 1) {
  pweibull(q, shape, scale, lower.tail = FALSE)
}

slnorm <- function(q, meanlog, sdlog = 1) {
  plnorm(q, meanlog, sdlog, lower.tail = FALSE)
}

sgamma <- function(q, shape, rate = 1) {
  pgamma(q, shape, rate, lower.tail = FALSE)
}

sgompertz <- function(q, shape, rate = 1) {
  pgompertz(q, shape, rate, lower.tail = FALSE)
}

sllogis <- function(q, shape, scale = 1) {
  pllogis(q, shape, scale, lower.tail = FALSE)
}

sgengamma <- function(q, mu = 0, sigma = 1, Q) {
  pgengamma(q, mu, sigma, Q, lower.tail = FALSE)
}
