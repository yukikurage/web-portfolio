import { marked } from 'marked';

export const parseMarkdown = (element) => (markdown) => () => {
  element.innerHTML = marked.parse(markdown);
}
