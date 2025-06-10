# Blockchain-Based Energy Demand Response Programs

A comprehensive blockchain solution for managing energy demand response programs using Clarity smart contracts on the Stacks blockchain.

## Overview

This system enables utilities to create demand response events, manage participants, measure performance, and distribute incentives in a transparent and automated manner using blockchain technology.

## Architecture

The system consists of five main smart contracts:

### 1. Utility Verification Contract (\`utility-verification.clar\`)
- Manages registration and verification of energy utilities
- Ensures only verified utilities can create demand response events
- Maintains utility registry with verification status

### 2. Participant Management Contract (\`participant-management.clar\`)
- Handles registration of demand response participants
- Manages participant profiles and energy capacity information
- Tracks participant status (active/inactive)

### 3. Demand Response Contract (\`demand-response.clar\`)
- Creates and manages demand response events
- Handles participant enrollment in events
- Records committed and actual energy reductions

### 4. Performance Measurement Contract (\`performance-measurement.clar\`)
- Calculates performance scores based on actual vs. committed reductions
- Tracks reliability scores and participant statistics
- Maintains historical performance data

### 5. Incentive Distribution Contract (\`incentive-distribution.clar\`)
- Manages incentive pools for demand response events
- Calculates earnings based on performance and actual reductions
- Distributes incentives to participants

## Key Features

- **Transparent Operations**: All transactions and data are recorded on the blockchain
- **Automated Incentives**: Smart contracts automatically calculate and distribute rewards
- **Performance Tracking**: Comprehensive performance measurement and statistics
- **Utility Verification**: Only verified utilities can create demand response programs
- **Participant Management**: Easy registration and management of program participants

## Smart Contract Functions

### Utility Verification
- \`register-utility\`: Register a new utility
- \`verify-utility\`: Verify a registered utility
- \`is-utility-verified\`: Check verification status
- \`get-utility\`: Get utility information

### Participant Management
- \`register-participant\`: Register as a program participant
- \`update-participant-status\`: Update active/inactive status
- \`get-participant\`: Get participant information
- \`is-participant-active\`: Check if participant is active

### Demand Response
- \`create-demand-event\`: Create a new demand response event
- \`participate-in-event\`: Join a demand response event
- \`record-actual-reduction\`: Record actual energy reduction
- \`get-demand-event\`: Get event information

### Performance Measurement
- \`calculate-performance\`: Calculate performance scores
- \`get-performance-record\`: Get performance data
- \`get-participant-stats\`: Get participant statistics

### Incentive Distribution
- \`create-incentive-pool\`: Create incentive pool for an event
- \`calculate-earnings\`: Calculate participant earnings
- \`distribute-incentive\`: Distribute incentives to participants
- \`get-participant-earnings\`: Get earnings information

## Installation

1. Clone the repository
2. Install dependencies: \`npm install\`
3. Run tests: \`npm test\`

## Testing

The project includes comprehensive tests using Vitest:

\`\`\`bash
npm test
\`\`\`

Tests cover:
- Contract functionality
- Error handling
- Edge cases
- Integration scenarios

## Usage Example

1. **Utility Registration**: A utility registers and gets verified
2. **Participant Registration**: Consumers register as participants
3. **Event Creation**: Utility creates a demand response event
4. **Participation**: Participants commit to energy reductions
5. **Performance Measurement**: System measures actual vs. committed reductions
6. **Incentive Distribution**: Participants receive rewards based on performance

## Security Considerations

- Only contract owners can register and verify utilities
- Participants can only update their own information
- Incentive distribution requires proper authorization
- All calculations are performed on-chain for transparency

## Future Enhancements

- Integration with IoT devices for automated measurement
- Advanced performance algorithms
- Multi-token incentive systems
- Cross-utility collaboration features

## Contributing

1. Fork the repository
2. Create a feature branch
3. Add tests for new functionality
4. Submit a pull request

## License

This project is licensed under the MIT License.
\`\`\`

Finally, let's create the PR details file:
