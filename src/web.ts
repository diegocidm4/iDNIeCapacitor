import { WebPlugin } from '@capacitor/core';

import type { idniecapPlugin } from './definitions';

export class idniecapWeb extends WebPlugin implements idniecapPlugin {
  async echo(options: { value: string }): Promise<{ value: string }> {
    console.log('ECHO', options);
    return options;
  }
}
