set Ingredients ordered;
set Nutrients;

var quantity{Ingredients}>=0;
var pos_slack{Nutrients}>=0;
var neg_slack{Nutrients}>=0;

param nutrients_per{Ingredients, Nutrients};
param necessary_nutrient{Nutrients};
param num_ingredients;
param weights{Nutrients};
# param total_mass;

minimize Goal:
sum{j in Nutrients} (weights[j]*(pos_slack[j] + neg_slack[j]));

subject to NutrientConstraint{j in Nutrients}:
sum{i in Ingredients} nutrients_per[i,j]*quantity[i] + pos_slack[j] - neg_slack[j] == necessary_nutrient[j];

subject to IngredientOrdering{i in Ingredients: ord(i) > 1}:
quantity[i] <= quantity[prev(i)];

subject to MassConstraint:
sum{i in Ingredients}(quantity[i]) = 1