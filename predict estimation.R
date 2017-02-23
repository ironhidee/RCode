# Display the variable names in the AARP data frame
names(AARP)

# Build a model: insurance_cost_model
insurance_cost_model <- lm(Cost~Age+Sex+Coverage, data=AARP)

# Construct a data frame: example_vals 
example_vals<- data.frame(Age=60, Sex="F", Coverage=200)

# Predict insurance cost using predict()
predict(insurance_cost_model, newdata= example_vals)

# Load statisticalModeling
require(statisticalModeling)

# Calculate model output using evaluate_model()
evaluate_model(insurance_cost_model, data=example_vals)