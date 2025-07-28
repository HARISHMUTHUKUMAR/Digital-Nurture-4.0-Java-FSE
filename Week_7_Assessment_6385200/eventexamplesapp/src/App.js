import React, { Component } from 'react';
import CurrencyConvertor from './CurrencyConvertor';
import './App.css';

class App extends Component {
  constructor(props) {
    super(props);
    this.state = {
      count: 0
    };

    this.increment = this.increment.bind(this);
    this.sayHello = this.sayHello.bind(this);
    this.decrement = this.decrement.bind(this);
    this.sayWelcome = this.sayWelcome.bind(this);
    this.handleSyntheticEvent = this.handleSyntheticEvent.bind(this);
  }

  increment() {
  this.setState(
    prevState => ({ count: prevState.count + 1 }),
    () => {
      this.sayHello(this.state.count); 
    }
  );
}

sayHello(memberNumber) {
  alert(`Hello! Member ${memberNumber}`);
}


  decrement() {
  if (this.state.count > 0) {
    this.setState(prevState => ({
      count: prevState.count - 1
    }));
  } else {
    alert("Counter cannot go below 0.");
  }
}

  sayWelcome(message) {
    alert(` ${message}`);
  }

  handleSyntheticEvent(e) {
    e.preventDefault();
    alert('I was clicked');
  }

  render() {
    return (
      <div className="App">
        <h1>React Event Examples</h1>
        <h2>Counter: {this.state.count}</h2>

        <button onClick={this.increment}>Increment</button>
        <button onClick={this.decrement}>Decrement</button>

        <br /><br />

        <button onClick={() => this.sayWelcome("Welcome to React Events!")}>Say Welcome</button>

        <br /><br />

        <button onClick={this.handleSyntheticEvent}>Click on me</button>

        <br /><br />

        <CurrencyConvertor />
      </div>
    );
  }
}

export default App;
