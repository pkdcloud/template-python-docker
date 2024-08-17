# # VERY INSECURE CODE
# import ast # added because its safer
# import os

# # Hardcoded sensitive information
# #API_KEY = "12345"
# #DB_PASSWORD = "password123"


# def insecure_function(user_input):
#     # Dangerous use of eval() - allows execution of arbitrary code
#     #result = eval(user_input) # Lets uset his as a demo
#     result = ast.literal_eval(user_input) # Lets use his as a demo
#     return result


# def insecure_file_handling():
#     # Reading and writing files with weak permissions
#     with open("sensitive_data.txt", "w") as file:
#         file.write(f"API_KEY={API_KEY}\nDB_PASSWORD={DB_PASSWORD}")

#     with open("sensitive_data.txt", "r") as file:
#         print(file.read())


# # Exposing sensitive environment variables
# def print_env_vars():
#     print(f"PATH={os.environ.get('PATH')}")
#     print(f"HOME={os.environ.get('HOME')}")


# # Example usage
# user_input = input("Enter something to evaluate: ")
# print(insecure_function(user_input))
# insecure_file_handling()
# print_env_vars()
