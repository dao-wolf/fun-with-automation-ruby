# Fun with Automation 🤖 using Ruby 💎

The `simple-solution.rb` script does the following:

- navigate to LinkedIn
- login using `email` and `password` from `test-data.json` file
- search for a person by `name` from `test-data.json` file
- check that the right person is found in the result by using `fullname` from `test-data.json` file
- open up the message box for the right person
- check the `fullname` of the person you're sending the message to again
- type and send the message

That's it!

the script uses only three modules:

- watir for performing actions on the browser
- webdrivers for launching local instance of a browser
- json to parse json from file

## Running the script

You just need to

- create a `test-data.json` file in the root directory of this project. It has to be the following shape:

```json
{
  "email": "test@test.test",
  "pwd": "test",
  "searchData": {
    "fullName": "test",
    "name": "test"
  }
}
```

- execute `bundle install` to install dependencies
- execute `ruby src\simple-solution.rb` in the terminal

## Future improvements

Using Page Object Model design pattern can greatly improve this simple solution.
