import js from '@eslint/js';
import tseslint from 'typescript-eslint';
import react from 'eslint-plugin-react';
import reactHooks from 'eslint-plugin-react-hooks';

export default [
  // Base JS rules
  js.configs.recommended,

  // TypeScript rules
  ...tseslint.configs.recommended,

  // Global settings
  {
    languageOptions: {
      ecmaVersion: 2021,
      sourceType: 'module',
      globals: {
        // Node
        process: 'readonly',
        console: 'readonly',
        global: 'readonly',

        // Browser
        window: 'readonly',
        document: 'readonly',
        fetch: 'readonly',

        // DOM / timers
        setTimeout: 'readonly',
        clearTimeout: 'readonly',
      },
    },
  },

  // React
  {
    plugins: {
      react,
      'react-hooks': reactHooks,
    },
    settings: {
      react: {
        version: 'detect',
      },
    },
    rules: {
      'react/react-in-jsx-scope': 'off', // React 17+
    },
  },

  // Test files (Vitest + jsdom)
  {
    files: ['**/*.test.ts', '**/*.test.tsx'],
    languageOptions: {
      globals: {
        describe: 'readonly',
        it: 'readonly',
        expect: 'readonly',
        vi: 'readonly',
        beforeEach: 'readonly',
        afterEach: 'readonly',
      },
    },
    rules: {
      '@typescript-eslint/no-explicit-any': 'off',
    },
  },
];
