import React, { useState } from 'react';
import './App.css';

function App() {
    const [response, setResponse] = useState("Hallo! Ich bin dein AI-Assistent.");

    const askAI = () => {
        const responses = [
            "Die Zukunft gehört der KI! 🤖",
            "Maschinelles Lernen revolutioniert die Welt!",
            "Ich denke, also bin ich... ein Algorithmus!",
            "Deep Learning verändert die Technologie!",
        ];
        setResponse(responses[Math.floor(Math.random() * responses.length)]);
    };

    return (
        <div className="App">
            <h1>Willkommen zu AI Vision</h1>
            <p>{response}</p>
            <button onClick={askAI}>Drück mich</button>
        </div>
    );
}

export default App;