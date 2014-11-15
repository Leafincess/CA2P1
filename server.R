library(shiny)
price <- function(S0,K,tau,sigma,r, option="call"){
  d1 <- (log(S0/K) + (r+sigma^2/2)*tau)/sigma/sqrt(tau)
  d2 <- d1 - sigma*sqrt(tau)
  if(option == "call"){
    optPrice <- S0 * pnorm(d1) - K * exp(-r*tau) * pnorm(d2)
    delta_S <- pnorm(d1)
    gamma_S2 <- dnorm(d1)/S0/sigma/sqrt(tau)
    theta_tau <- -S0*dnorm(d1)*sigma/2/tau - r*K*exp(-r*tau)*dnorm(d2)
    vega_sigma <- S0*sqrt(tau)*dnorm(d1)
    rho_r <- K * tau * exp(-r*tau)*dnorm(d2)
  } else if(option == "put"){
    optPrice <-  K * exp(-r*tau) * pnorm(-d2) - S0 * pnorm(-d1)
    delta_S <- pnorm(d1)-1
    gamma_S2 <- dnorm(d1)/S0/sigma/sqrt(tau)
    theta_tau <- -S0*dnorm(d1)*sigma/2/tau + r*K*exp(-r*tau)*dnorm(-d2)
    vega_sigma <- S0*sqrt(tau)*dnorm(d1)
    rho_r <- -K * tau * exp(-r*tau)*dnorm(-d2)
  } else {
    return(rep(NA, 6))
  }
  return(c(optPrice, delta_S, gamma_S2, theta_tau, vega_sigma, rho_r))
}
# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  optResult <- reactive({
    opt <- price(S0=input$S0, K=input$K, tau=input$tau, sigma=input$sigma/100, 
                       r=input$r/100, option=input$option)
    opt <- round(opt, digits=4)
    })
  output$text <- renderText({
    paste("The European",input$option, "price is:", optResult()[1])
  })
  output$text1 <- renderText({
    paste("The Greeks of the", input$option, "option are:")
  })
  output$textDelta <- renderText({
    paste("Delta (dy/dS):", optResult()[2])
  })
  output$textGamma <- renderText({
    paste("Gamma (d2y/dS2):", optResult()[3])
  })
  output$textTheta <- renderText({
    paste("Theta (dy/dT):", optResult()[4])
  })
  output$textVega <- renderText({
    paste("Vega (dy/dSigma):", optResult()[5])
  })
  output$textRho <- renderText({
    paste("Rho (dy/dR):", optResult()[6])
  })
  
})
