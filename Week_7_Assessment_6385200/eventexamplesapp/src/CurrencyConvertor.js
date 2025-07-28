import React, { Component } from 'react';

class CurrencyConvertor extends Component {
  constructor(props) {
    super(props);
    this.state = {
      rupees: '',
      currency: 'EUR',
      converted: ''
    };

    this.handleAmountChange = this.handleAmountChange.bind(this);
    this.handleSubmit = this.handleSubmit.bind(this);
  }

  handleAmountChange(e) {
    this.setState({ rupees: e.target.value });
  }

  handleSubmit(e) {
    e.preventDefault();

    const amount = parseFloat(this.state.rupees);
    const euroRate = 90; // 1 Euro = 90 INR

    if (!amount || amount <= 0) {
      alert("Please enter a valid amount in INR.");
      return;
    }

    const converted = (amount / euroRate).toFixed(2);
    this.setState({ converted });
  }

  render() {
    return (
      <div>
        <h2>Currency Convertor (INR to Euro)</h2>
        <form onSubmit={this.handleSubmit}>
          <label>Amount in INR:</label><br />
          <input
            type="number"
            value={this.state.rupees}
            onChange={this.handleAmountChange}
            placeholder="Enter INR amount"
            required
          /><br /><br />

          <label>Currency:</label><br />
          <input
            type="text"
            value={this.state.currency}
            readOnly
          /><br /><br />

          <button type="submit">Convert</button>
        </form>

        {this.state.converted && (
          <p>
            <strong>Converted Amount:</strong> EUR {this.state.converted}
          </p>
        )}
      </div>
    );
  }
}

export default CurrencyConvertor;
