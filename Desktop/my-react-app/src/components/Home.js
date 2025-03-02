import React, { useState, useEffect } from 'react';
import { Link } from 'react-router-dom';
import 'bootstrap/dist/css/bootstrap.min.css';
import '@fortawesome/fontawesome-free/css/all.min.css';
import './Home.css'; // Ensure you create this CSS file for custom styles

function Home() {
  const [visibleFeature, setVisibleFeature] = useState(0);

  useEffect(() => {
    const timer = setInterval(() => {
      setVisibleFeature((prev) => prev + 1);
    }, 1000); // Change the interval to control the delay between feature appearances

    // Clear the interval when the component is unmounted
    return () => clearInterval(timer);
  }, []);

  return (
    <>
      {/* Navigation Bar */}
      <nav className="navbar navbar-expand-lg navbar-dark bg-dark">
        <div className="container">
          <Link className="navbar-brand" to="/">SME Tech Predictor</Link>
          <button className="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span className="navbar-toggler-icon"></span>
          </button>
          <div className="collapse navbar-collapse" id="navbarNav">
            <ul className="navbar-nav ms-auto">
              <li className="nav-item">
                <Link className="nav-link" to="/">Home</Link>
              </li>
              <li className="nav-item">
                <Link className="nav-link" to="/questionnaire">Questionnaire</Link>
              </li>
            </ul>
          </div>
        </div>
      </nav>

      {/* Hero Section */}
      <section className="hero-section">
        <div className="hero-content">
          <h1>SME Tech Maturity Predictor</h1>
          <p>Empowering small and medium-sized enterprises to assess and enhance their technical capabilities.</p>
          <Link to="/questionnaire" className="btn btn-primary">Check here</Link>
        </div>
      </section>

      {/* Features Section */}
      <section id="features" className="features-section">
        <div className="container">
          <div className="row">
            <div className={`col-md-4 feature ${visibleFeature >= 1 ? 'visible' : ''}`}>
              <div className="feature-icon">
                <i className="fas fa-chart-line"></i>
              </div>
              <h3>Comprehensive Analysis</h3>
              <p>Get a detailed evaluation of your enterprise's technical maturity across various dimensions.</p>
            </div>
            <div className={`col-md-4 feature ${visibleFeature >= 2 ? 'visible' : ''}`}>
              <div className="feature-icon">
                <i className="fas fa-user-shield"></i>
              </div>
              <h3>Personalized Recommendations</h3>
              <p>Receive tailored suggestions to improve your technical infrastructure and processes.</p>
            </div>
            <div className={`col-md-4 feature ${visibleFeature >= 3 ? 'visible' : ''}`}>
              <div className="feature-icon">
                <i className="fas fa-mobile-alt"></i>
              </div>
              <h3>Mobile-Friendly</h3>
              <p>Access our platform on any device, ensuring flexibility and ease of use.</p>
            </div>
          </div>
        </div>
      </section>

      {/* Footer */}
      <footer className="footer">
        <div className="container">
          <p>&copy; 2024 SME Tech Maturity Predictor. All Rights Reserved.</p>
        </div>
      </footer>
    </>
  );
}

export default Home;
