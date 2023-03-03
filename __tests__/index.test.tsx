import { testFunc } from '@/lib/test'

describe('testFunc', () => {
  it('plus 1', () => {
    expect(testFunc(1)).toBe(2)
  })
})