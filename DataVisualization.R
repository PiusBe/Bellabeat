#DATA VISUALIZATION
ggplot(data=Activity, aes(x=TotalSteps, y=SedentaryMinutes)) + 
  geom_point() + geom_smooth() + 
  labs(title="Total Steps vs Sedentary Minutes")


ggplot(data=Sleep, aes(x=TotalMinutesAsleep, y=TotalTimeInBed)) + 
  geom_point()+ geom_smooth() + 
  labs(title="Minutes Asleep vs. Time in Bed Minutes")


ggplot(data=Activity, aes(x=TotalSteps, y=Calories)) +
  geom_point() + geom_smooth() + 
  labs(title="Total Steps vs. Calories")


Combined_data <- merge(Weight, Intensities, by="Id", all=TRUE)
Combined_data$time <- format(Combined_data$Date, format = "%H:%M:%S")
ggplot(data=Combined_data, aes(x=time, y=VeryActiveMinutes)) + 
  geom_histogram(stat = "identity", fill='darkblue') +
  theme(axis.text.x = element_text(angle = 90)) +
  labs(title="Total very Active Intensity vs. Time ")