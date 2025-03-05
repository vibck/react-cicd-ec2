import { render, screen } from '@testing-library/react';
import App from './App';

test('renders AI greeting', () => {
    render(<App />);
    const textElement = screen.getByText(/Ich bin dein AI-Assistent/i);
    expect(textElement).toBeInTheDocument();
});