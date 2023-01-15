import openai
import argparse
import os
# create the parser
parser = argparse.ArgumentParser()
# add the string argument
parser.add_argument("string_arg", type=str, help="A string argument")
# parse the arguments
args = parser.parse_args()


# set the API key
openai.api_key = os.environ.get('API_KEY') 

# define the model and prompt
model_engine = "text-davinci-003"
prompt = args.string_arg

response = openai.Completion.create(
  model=model_engine,
  prompt=prompt,
  temperature=0.5,
  max_tokens=4000,
  presence_penalty=0.0
)
# print the response
print(response["choices"][0]["text"])