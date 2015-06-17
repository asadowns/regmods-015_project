fit <- lm(mpg~factor(am), mtcars)
fit2 <- update(fit, mpg~factor(am)+wt)
fit3 <- update(fit, mpg~factor(am)+wt+hp)
fit4 <- update(fit, mpg~factor(am)+wt+hp+factor(cyl))
resid <- resid(fit3)

mtCars <- tbl_df(mtcars) %>%
  mutate(resid.am = resid) %>%
  group_by(am) %>%
  arrange(desc(resid.am))

fit2 <- update(fit, mpg~factor(am)+factor(gear))
fit3 <- update(fit, mpg~factor(am)+factor(gear)+wt)
anova(fit,fit2,fit3,fit4)


fit2 <- lm(mpg~factor(am)*factor(vs),mtcars)
resid2 <- resid(fit2)

residFrame <- data.frame(x=mtcars$mpg, y=resid, colour=factor(mtcars$am))

residFrame2 <- data.frame(x=mtcars$mpg, y=resid2, colour=factor(mtcars$am))

g <- ggplot(mtcars, aes(x=factor(am), y=mpg,colour=factor(am))) + 
  geom_point() +
  geom_smooth(method="lm",aes(group=1))
g

g <- ggplot(mtcars, aes(x=factor(am), y=mpg,colour=factor(am))) + 
  geom_point() +
  facet_wrap(~gear)
g
  

g <- ggplot(residFrame,aes(x=x,y=y,colour=colour)) +
  geom_hline(yintercept=0, size=2) +
  geom_point(size = 7, alpha = 0.4) +
  geom_point(size = 5, alpha = 0.4)
g

g <- ggplot(residFrame2,aes(x=x,y=y,colour=colour)) +
  geom_hline(yintercept=0, size=2) +
  geom_point(size = 7, alpha = 0.4) +
  geom_point(size = 5, alpha = 0.4)
g
