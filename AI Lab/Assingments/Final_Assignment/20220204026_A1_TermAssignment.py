import pandas as pd
from sklearn.model_selection import train_test_split

from sklearn.preprocessing import StandardScaler

from sklearn.tree import DecisionTreeClassifier
from sklearn.naive_bayes import GaussianNB
from sklearn.neighbors import KNeighborsClassifier
from sklearn.metrics import accuracy_score, precision_score, recall_score, f1_score

import matplotlib.pyplot as plt
from sklearn.metrics import confusion_matrix, ConfusionMatrixDisplay

# Load the dataset
df = pd.read_csv('diabetes_prediction_dataset.csv')

# Examine the structure
print("\n--- Dataset Shape (rows, columns) ---")
print(df.shape) # Shows total number of rows and columns

print("\n--- First 5 Rows (head) ---")
print(df.head(5))   # Shows the first 5 rows so we can see the data

print("\n--- Dataset Info ---")
print(df.info())    # Shows data types and non-null counts for each column

print("\n--- Statistical Summary (describe) ---")
print(df.describe())    # Shows mean, std, min, max for each column

print("\n--- Column Names ---")
for col in df.columns:
    print(" ", col)

# Keeping only numeric features
# will remove 'gender' and 'smoking_history' in this case
df_numeric = df.select_dtypes(include=['number'])

print("\n--- After Processing Column Names ---")
for col in df_numeric.columns:
    print(" ", col)

# Handling missing values (dropping rows with NaNs if any)
df_numeric = df_numeric.dropna()

# Defining Features (X) and Target (y)
X = df_numeric.drop('diabetes', axis=1) # Target variable is 'diabetes'
y = df_numeric['diabetes']

# Split the dataset (20% for testing)
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.20, random_state=42, stratify=y) #keeping same ratio in y

print(f"\nTraining set size: {X_train.shape[0]}")
print(f"Testing set size: {X_test.shape[0]}")

# Feature Scaling
scaler = StandardScaler()
X_train = scaler.fit_transform(X_train)
X_test  = scaler.transform(X_test)       #so that no data leakage

# Initialize models
models = {
    "Decision Tree": DecisionTreeClassifier(max_depth=5, random_state=42),
    "Naïve Bayes": GaussianNB(),
    "KNN": KNeighborsClassifier(n_neighbors=5)
}

# Dictionary to store results
results = {}

print("\n--- Model Evaluation Results ---")

for name, model in models.items():
    # Train
    model.fit(X_train, y_train)

    # Predict
    y_pred = model.predict(X_test)

    # Evaluate
    accuracy = accuracy_score(y_test, y_pred)
    precision = precision_score(y_test, y_pred)
    recall = recall_score(y_test, y_pred)
    f1 = f1_score(y_test, y_pred)

    results[name] = [accuracy, precision, recall, f1]

    print(f"\nModel: {name}")
    print(f" Accuracy:  {accuracy:.4f}")
    print(f" Precision: {precision:.4f}")
    print(f" Recall:    {recall:.4f}")
    print(f" F1-Score:  {f1:.4f}")

    cm = confusion_matrix(y_test, y_pred)
    disp = ConfusionMatrixDisplay(cm, display_labels=['No Diabetes', 'Diabetes'])
    disp.plot()
    plt.title(name)
    plt.show()

# Create a DataFrame for comparison
comparison_df = pd.DataFrame(results, index=['Accuracy', 'Precision', 'Recall', 'F1-Score'])

# Plotting
comparison_df.T.plot(kind='bar', figsize=(10, 6))   #transposing to bring Models in x-axis instead of scores
plt.title('Comparison of ML Models on Diabetes Dataset')
plt.ylabel('Score')
plt.xticks(rotation=0)              # so that labels don't stay tilted at 90-degree angle
plt.legend(loc='lower right')
plt.grid(axis='y', linestyle='--', alpha=0.7)     # drawing a semi transparent grid line
plt.show()
