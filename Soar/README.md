# Adding React to Rails

## Learning Goals

- Use `create-react-app` to generate a new React application within a Rails
  project
- Proxy requests from React to Rails in development
- Use the `foreman` gem to run React and Rails together

## Introduction

In the last lesson, we created a Rails API from scratch. Now it's time to see
how we can add a React frontend application as well.

There are a number of ways to use React and Rails together, such as using the
[`webpacker` gem](https://github.com/rails/webpacker) to manage JavaScript as
part of your Rails application. However, we like the simplicity and the tooling
that you get out of using [`create-react-app`](https://create-react-app.dev/) to
generate a new React application within Rails. If you've used `create-react-app`
before, you should feel right at home! We can also add a few additional tools to
the process to make running React and Rails together a bit easier.

## Generating a React Application

To get started, let's spin up our React application using `create-react-app`:

```console
$ npx create-react-app client --use-npm
```

This will create a new React application in a `client` folder, and will use npm
instead of yarn to manage our dependencies.

When we're running React and Rails in development, we'll need two separate
servers running on different ports — we'll run React on port 4000, and
Rails on port 3000. Whenever we want to make a request to our Rails API from
React, we'll need to make sure that our requests are going to port 3000.

We can simplify this process of making requests to the correct port by using
`create-react-app` in development to [proxy the requests to our API][proxy].
This will let us write our network requests like this:

```js
fetch("/movies");
// instead of fetch("http://localhost:3000/movies")
```

To set up this proxy feature, open the `package.json` file in the `client`
directory and add this line at the top level of the JSON object:

```json
"proxy": "http://localhost:3000"
```

Let's also update the "start" script in the the `package.json` file to specify a
different port to run our React app in development:

```json
"scripts": {
  "start": "PORT=4000 react-scripts start"
}
```

With that set up, let's try running our servers! In your terminal, run Rails:

```console
$ rails s
```

Then, open a new terminal, and run React:

```console
$ npm start --prefix client
```

This will run `npm start` in the client directory. Verify that your app is
working by visiting:

- [http://localhost:4000](http://localhost:4000) to view the React application
- [http://localhost:3000/movies](http://localhost:3000/movies) to view the Rails
  application

We can also see how to make a request using `fetch`. In the React application,
update your `App.js` file with the following code:

```jsx
import { useEffect } from "react";

function App() {
  useEffect(() => {
    fetch("/movies")
      .then((r) => r.json())
      .then((movies) => console.log(movies));
  }, []);

  return <h1>Hello from React!</h1>;
}

export default App;
```

This will use the `useEffect` hook to fetch data from our Rails API, which you
can then view in the console.

## Running React and Rails Together

Since we'll often want to run our React and Rails applications together, it can
be helpful to be able to run them from just one command in the terminal instead
of opening multiple terminals.

To facilitate this, we'll use the excellent [foreman][] gem. Install it:

```console
$ gem install foreman
```

Foreman works with a special kind of file known as a Procfile, which lists
different processes to run for our application. Some hosting services, such as
Heroku, use a Procfile to run applications, so by using a Procfile in
development as well, we'll simplify the deploying process later.

In the root directory, create a file `Procfile.dev` and add this code:

```txt
web: PORT=4000 npm start --prefix client
api: PORT=3000 rails s
```

Then, run it with Foreman:

```console
$ foreman start -f Procfile.dev
```

This will start both React and Rails on separate ports, just like before; but
now we can run both with one command!

**There is one big caveat to this approach**: by running our client and server
in the same terminal, it can be more challenging to read through the server logs
and debug our code. Furthermore, `byebug` will not work. If you're doing a lot of
debugging in the terminal, you should run the client and server separately to
get a cleaner terminal output and allow terminal-based debugging with `byebug`.

You can run each application separately by opening two terminal windows and
running each of these commands in a separate window:

```console
$ npm start --prefix client
$ rails s
```

This will run React on port 4000 (thanks to the configuration in the
`client/package.json` file), and Rails on port 3000 (the default port).

## Conclusion

In the past couple lessons, we've seen how to put together the two pieces we'll
need for full-stack applications by using `rails new` to create a new Rails API,
and `create-react-app` to create a React project. Throughout the rest of this
module, we'll focus on how our two applications communicate and share data.

## Check For Understanding

Before you move on, make sure you can answer the following questions:

1. What options do you have for running Rails and React at the same time?
2. What are the advantages and disadvantages of using `foreman` as described in
   this lesson?

## Resources

- [Proxying API Requests in Create React App][proxy]

[proxy]: https://create-react-app.dev/docs/proxying-api-requests-in-development/
[foreman]: https://github.com/ddollar/foreman
