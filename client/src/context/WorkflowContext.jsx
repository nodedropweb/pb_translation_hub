import { createContext } from 'react';

export const WorkflowContext = createContext({
  priorityMode: false,
  setPriorityMode: () => {}
});
