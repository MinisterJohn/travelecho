import React from 'react';
import { BrowserRouter as Router, Route, Routes } from 'react-router-dom'; // Ensure correct import
import Home from './components/Home';
import Questionnaire from './components/Questionnaire';
import 'bootstrap/dist/css/bootstrap.min.css';

function App() {
  return (
    <Router>
      <Routes> {/* Routes component replaces Switch in React Router v6 */}
        <Route path="/" element={<Home />} /> {/* Define route for Home */}
        <Route path="/questionnaire" element={<Questionnaire />} /> {/* Define route for Questionnaire */}
      </Routes>
    </Router>
  );
}

export default App;
