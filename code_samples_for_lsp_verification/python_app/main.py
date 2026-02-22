# main.py
from utils.calculator import Calculator

def main():
    """Main function to demonstrate Calculator usage."""
    # Create an instance of the Calculator class
    calc = Calculator()

    # Use methods from the class
    result_add = calc.add(10, 5)
    print(f"Addition result: {result_add}")

    result_subtract = calc.subtract(10, 5)
    print(f"Subtraction result: {result_subtract}")

    # Check LSP features:
    # 1. Go to Definition on 'Calculator' should go to utils/calculator.py
    # 2. Go to Definition on 'add' should also go to utils/calculator.py
    # 3. Find References on 'Calculator' should find usages here.
    # 4. Hover over 'calc' should show the type 'Calculator'.
    # 5. Renaming the 'add' method in the Calculator class should update it here.

if __name__ == "__main__":
    main()
