import React, { useState } from 'react';
import BookDetails from './BookDetails';
import BlogDetails from './BlogDetails';
import CourseDetails from './CourseDetails';
import './App.css';

function App() {
  const [activeComponent, setActiveComponent] = useState('book');

  // 1. if-else (element variable)
  let componentToRender;
  if (activeComponent === 'book') {
    componentToRender = <BookDetails />;
  } else if (activeComponent === 'blog') {
    componentToRender = <BlogDetails />;
  } else {
    componentToRender = <CourseDetails />;
  }

  return (
    <div className="App">
      <h1>Blogger App</h1>

      {/* Toggle buttons */}
      <button onClick={() => setActiveComponent('book')}>Show Book Details</button>
      <button onClick={() => setActiveComponent('blog')}>Show Blog Details</button>
      <button onClick={() => setActiveComponent('course')}>Show Course Details</button>

      <hr />

      {/* Method 1: Using element variable (if-else) */}
      {componentToRender}

      {/* Method 2: Using ternary operator */}
      {/* {activeComponent === 'book'
        ? <BookDetails />
        : activeComponent === 'blog'
        ? <BlogDetails />
        : <CourseDetails />
      } */}

      {/* Method 3: Using logical && */}
      {/* {activeComponent === 'book' && <BookDetails />}
      {activeComponent === 'blog' && <BlogDetails />}
      {activeComponent === 'course' && <CourseDetails />} */}

      {/* Method 4: Switch (Optional advanced) */}
      {/* {(() => {
        switch (activeComponent) {
          case 'book':
            return <BookDetails />;
          case 'blog':
            return <BlogDetails />;
          case 'course':
            return <CourseDetails />;
          default:
            return <p>Please select a component.</p>;
        }
      })()} */}
    </div>
  );
}

export default App;
