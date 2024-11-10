import { registerPlugin } from '@capacitor/core';

import type { idniecapPlugin } from './definitions';

const idniecap = registerPlugin<idniecapPlugin>('idniecap', {
  web: () => import('./web').then((m) => new m.idniecapWeb()),
});

export * from './definitions';
export { idniecap };
