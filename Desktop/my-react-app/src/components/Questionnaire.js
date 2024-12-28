import React, { useState } from 'react';
import 'bootstrap/dist/css/bootstrap.min.css';
import { Modal, Button } from 'react-bootstrap';
import { Link } from 'react-router-dom';
import './Questionnaire.css'; // Ensure you create this CSS file for custom styles

function Questionnaire() {
  const [currentQuestion, setCurrentQuestion] = useState(1);
  const [responses, setResponses] = useState({});
  const [totalScore, setTotalScore] = useState(0);
  const [showModal, setShowModal] = useState(false);

  const totalQuestions = 15;
  const maxScore = totalQuestions * 5; // Each question has a max score of 5

  // Updated questions with options and scores
  const questions = [
    { id: 1, question: "How does your organization handle technology adoption?", options: [{ text: "Not at all", score: 2 }, { text: "Ad-hoc", score: 3 }, { text: "Systematic and planned", score: 5 }] },
    { id: 2, question: "How often do you update your technology infrastructure?", options: [{ text: "Rarely", score: 2 }, { text: "Occasionally", score: 3 }, { text: "Regularly", score: 5 }] },
    { id: 3, question: "What is your approach to process management?", options: [{ text: "Manual processes", score: 2 }, { text: "Basic tools", score: 3 }, { text: "Automated systems", score: 5 }] },
    { id: 4, question: "How do you manage project risks?", options: [{ text: "Reactively", score: 2 }, { text: "With some planning", score: 3 }, { text: "Proactively with a formal risk management plan", score: 5 }] },
    { id: 5, question: "How does your organization handle data security?", options: [{ text: "Basic security measures", score: 2 }, { text: "Standard practices", score: 3 }, { text: "Advanced security protocols", score: 5 }] },
    { id: 6, question: "How frequently do you train your staff on new technologies?", options: [{ text: "Rarely", score: 2 }, { text: "Occasionally", score: 3 }, { text: "Regularly", score: 5 }] },
    { id: 7, question: "How do you manage customer feedback?", options: [{ text: "Infrequently", score: 2 }, { text: "Occasionally", score: 3 }, { text: "Regularly with a structured process", score: 5 }] },
    { id: 8, question: "What is your approach to process improvement?", options: [{ text: "Ad-hoc", score: 2 }, { text: "Periodic reviews", score: 3 }, { text: "Continuous improvement", score: 5 }] },
    { id: 9, question: "How do you manage your IT assets?", options: [{ text: "Manually", score: 2 }, { text: "Using basic tools", score: 3 }, { text: "Using advanced asset management systems", score: 5 }] },
    { id: 10, question: "How do you handle project documentation?", options: [{ text: "Minimal", score: 2 }, { text: "Basic", score: 3 }, { text: "Comprehensive and up-to-date", score: 5 }] },
    { id: 11, question: "How do you approach innovation?", options: [{ text: "Reactive", score: 2 }, { text: "Occasionally", score: 3 }, { text: "Proactively and systematically", score: 5 }] },
    { id: 12, question: "How do you ensure compliance with industry standards?", options: [{ text: "Ad-hoc", score: 2 }, { text: "Periodic audits", score: 3 }, { text: "Continuous compliance monitoring", score: 5 }] },
    { id: 13, question: "How do you approach strategic planning?", options: [{ text: "Short-term focus", score: 2 }, { text: "Annual planning", score: 3 }, { text: "Long-term strategic planning", score: 5 }] },
    { id: 14, question: "How do you track and measure performance?", options: [{ text: "Basic metrics", score: 2 }, { text: "Key performance indicators", score: 3 }, { text: "Comprehensive performance management system", score: 5 }] },
    { id: 15, question: "How do you handle technological disruptions?", options: [{ text: "Reactive responses", score: 2 }, { text: "Planned responses", score: 3 }, { text: "Proactive and adaptable strategies", score: 5 }] }
  ];

  const handleChange = (e) => {
    const value = parseInt(e.target.value);
    const questionId = questions[currentQuestion - 1].id;

    // Calculate new total score based on previous and new value
    const previousScore = responses[questionId] || 0;
    const newTotalScore = totalScore - previousScore + value;

    setResponses({
      ...responses,
      [questionId]: value,
    });

    setTotalScore(newTotalScore);
  };

  const handleNext = () => {
    if (currentQuestion < totalQuestions) {
      setCurrentQuestion((prev) => prev + 1);
    } else {
      setShowModal(true);
    }
  };

  const handlePrevious = () => {
    if (currentQuestion > 1) {
      setCurrentQuestion((prev) => prev - 1);
    }
  };

  const calculateMaturityLevel = (score) => {
    if (score <= (maxScore * 0.20)) return "Very Low";
    if (score <= (maxScore * 0.40)) return "Low";
    if (score <= (maxScore * 0.60)) return "Moderate";
    if (score <= (maxScore * 0.80)) return "High";
    return "Very High";
  };

  const calculatePercentage = (score) => {
    return ((score / maxScore) * 100).toFixed(2);
  };

  const getRecommendations = (maturityLevel) => {
    switch (maturityLevel) {
      case "Very Low":
        return (
          <>
            <h4>Recommendations for Very Low Maturity:</h4>
            <ul>
              <li>Implement basic project management tools to track progress.</li>
              <li>Start incorporating structured technology adoption processes.</li>
              <li>Invest in foundational staff training to enhance skills.</li>
            </ul>
          </>
        );
      case "Low":
        return (
          <>
            <h4>Recommendations for Low Maturity:</h4>
            <ul>
              <li>Expand the use of technology management tools for better tracking.</li>
              <li>Increase the frequency of staff training sessions.</li>
              <li>Adopt more structured processes for managing risks and security.</li>
            </ul>
          </>
        );
      case "Moderate":
        return (
          <>
            <h4>Recommendations for Moderate Maturity:</h4>
            <ul>
              <li>Integrate advanced management and collaboration tools.</li>
              <li>Regularly review and update technology practices and processes.</li>
              <li>Enhance documentation and compliance monitoring.</li>
            </ul>
          </>
        );
      case "High":
        return (
          <>
            <h4>Recommendations for High Maturity:</h4>
            <ul>
              <li>Maintain and refine advanced tools and practices.</li>
              <li>Ensure continuous improvement through regular reviews and feedback.</li>
              <li>Foster a culture of innovation and proactive risk management.</li>
            </ul>
          </>
        );
      case "Very High":
        return (
          <>
            <h4>Recommendations for Very High Maturity:</h4>
            <ul>
              <li>Share best practices with other organizations or teams.</li>
              <li>Lead industry initiatives and contribute to community knowledge.</li>
              <li>Explore cutting-edge technologies and methodologies for further enhancement.</li>
            </ul>
          </>
        );
      default:
        return null;
    }
  };

  const maturityLevel = calculateMaturityLevel(totalScore);
  const percentageScore = calculatePercentage(totalScore);

  return (
    <div className="background">
      {/* Navigation Bar */}
      <nav className="navbar navbar-expand-lg navbar-dark bg-dark">
        <div className="container">
          <Link className="navbar-brand" to="/">Home</Link>
        </div>
      </nav>

      {/* Questionnaire Content */}
      <div className="container mt-4">
        <h1 className="mb-4">SME Technical Maturity Level Questionnaire</h1>

        {/* Display Current Question */}
        <div className="mb-4">
          <h3>{questions[currentQuestion - 1].question}</h3>
          {questions[currentQuestion - 1].options.map((option, index) => (
            <div key={index} className="form-check">
              <input
                className="form-check-input"
                type="radio"
                name={`question${questions[currentQuestion - 1].id}`}
                id={`option${index}`}
                value={option.score}
                onChange={handleChange}
                checked={responses[questions[currentQuestion - 1].id] === option.score}
              />
              <label className="form-check-label" htmlFor={`option${index}`}>
                {option.text}
              </label>
            </div>
          ))}
        </div>

        <div className="d-flex justify-content-between">
          <Button
            variant="secondary"
            onClick={handlePrevious}
            disabled={currentQuestion === 1}
          >
            Previous
          </Button>
          <Button
            variant="primary"
            onClick={handleNext}
          >
            {currentQuestion === totalQuestions ? "Finish" : "Next"}
          </Button>
        </div>
      </div>

      {/* Results Modal */}
      <Modal show={showModal} onHide={() => setShowModal(false)}>
        <Modal.Header closeButton>
          <Modal.Title>Results</Modal.Title>
        </Modal.Header>
        <Modal.Body>
          <h4>Your Technical Maturity Level: {maturityLevel}</h4>
          <p>Your score: {totalScore} out of {maxScore} ({percentageScore}%)</p>
          {getRecommendations(maturityLevel)}
        </Modal.Body>
        <Modal.Footer>
          <Button variant="secondary" onClick={() => setShowModal(false)}>
            Close
          </Button>
          <Button variant="primary">
            <Link to="/" style={{ color: 'white', textDecoration: 'none' }}>Back to Home</Link>
          </Button>
        </Modal.Footer>
      </Modal>
    </div>
  );
}

export default Questionnaire;
