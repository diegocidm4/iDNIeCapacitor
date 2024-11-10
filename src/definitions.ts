export interface idniecapPlugin {
  echo(options: { value: string }): Promise<{ value: string }>;
}
