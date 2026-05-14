import React, { useState } from 'react';

/**
 * @file Tooltip.jsx
 * A simple, CSS-driven tooltip component for helpful UI hints.
 */
const Tooltip = ({ text, children }) => {
  const [show, setShow] = useState(false);
  return (
    <div className="relative inline-block" onMouseEnter={() => setShow(true)} onMouseLeave={() => setShow(false)}>
      {children}
      {show && (
        <div className="absolute bottom-full left-1/2 -translate-x-1/2 mb-2 px-2 py-1 bg-black text-white text-[10px] rounded pointer-events-none z-[100] whitespace-nowrap animate-in fade-in zoom-in-95 duration-200">
          {text}
          <div className="absolute top-full left-1/2 -translate-x-1/2 border-4 border-transparent border-t-black"></div>
        </div>
      )}
    </div>
  );
};

export default Tooltip;
