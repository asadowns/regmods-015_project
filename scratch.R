fit0 <- lm(mpg~1,mtcars)
fit1 <- lm(mpg~am, mtcars)
fit2 <- update(fit, mpg~am+wt)
fit3 <- update(fit, mpg~am+wt+hp)
fit4 <- update(fit, mpg~am+wt+hp+factor(cyl))
resid <- resid(fit)
resid2 <- resid(fit3)
anova(fit,fit2,fit3)
n <- nrow(mtcars)


mtCars <- tbl_df(mtcars) %>%
  mutate(resid.am = resid) %>%
  group_by(am) %>%
  arrange(desc(resid.am))

e <- c(resid(fit0),resid(fit1),resid(fit4))

fit <- factor(c(rep('itc',n),rep('am',n),rep('am+wt+hp',n)),levels=c('itc','am','am+wt+hp'))
ggplot(data.frame(e=e,fit=fit),aes(y=e,x=fit,fill=fit)) +
  geom_dotplot(binaxis='y',size=1,stackdir='center',binwidth = 0.5) +
  xlab('Fitting Approach') +
  ylab('Residual MPG')
residFrame <- data.frame(x=mtcars$mpg, y=resid, colour=factor(mtcars$am))

residFrame2 <- data.frame(x=mtcars$mpg, y=resid2, colour=factor(mtcars$am))

g <- ggplot(mtcars, aes(x=am, y=mpg,colour=am)) + 
  geom_point() +
  stat_smooth(method="lm",formula=y~x,aes(group=1)) +
  geom_abline(intercept = (coef(fit3)[1] + coef(fit3)[3] + coef(fit3)[4]), slope = coef(fit3)[2], size = 2) +
  geom_abline(intercept=coef(fit)[1], slope= coef(fit)[2], size=1)
g

g <- ggplot(mtcars, aes(x=factor(am), y=mpg,colour=factor(am))) + 
  geom_point() +
  facet_wrap(~wt+hp)
g

g <- ggplot(mtcars, aes(x=factor(am), y=mpg,colour=factor(am))) + 
  geom_point() +
  facet_wrap(~wt+hp)
g  

g <- ggplot(residFrame,aes(x=x,y=y, colour=colour)) +
  geom_hline(yintercept=0, size=2) +
  geom_point(size = 7, alpha = 0.4) +
  geom_point(size = 5, alpha = 0.4)
#for (i in 1 : n) {
#  print(i)
#  g <- g + geom_line(aes(x=c(x[1], x[i]), y=c(y[i], 0)))
#}
g

qplot(.fitted, .resid, data = fit1, colour=factor(am)) +
  geom_hline(yintercept = 0) +
  geom_smooth(method='lm',se=FALSE) + xlab('Fitted values\n lm(mpg~am)')

g <- ggplot(residFrame2,aes(x=x,y=y,colour=colour)) +
  geom_hline(yintercept=0, size=2) +
  geom_point(size = 7, alpha = 0.4) +
  geom_point(size = 5, alpha = 0.4)
g
