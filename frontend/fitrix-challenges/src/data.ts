export type Challenge = {
  id: string
  title: string
  time: string
  coach: string
  category: string
  status: 'join' | 'full'
  icon: 'zap' | 'yoga' | 'bike'
}

export const challenges: Challenge[] = [
  { id: 'hiit', title: 'HIIT Circuit', time: '6:30 PM', coach: 'Coach Rae', category: 'Strength', status: 'join', icon: 'zap' },
  { id: 'yoga', title: 'Power Yoga', time: '7:15 PM', coach: 'Coach Tom', category: 'Flex', status: 'full', icon: 'yoga' },
  { id: 'spin', title: 'Spin & Burn', time: '8:00 PM', coach: 'Coach Alex', category: 'Cardio', status: 'join', icon: 'bike' },
]

export type Entry = {
  rank: number
  name: string
  initials: string
  attempts: number
  pts: number
  self?: boolean
}

export const leaderboard: Entry[] = [
  { rank: 1, name: 'Sara K.', initials: 'SK', attempts: 14, pts: 980 },
  { rank: 2, name: 'Diego M.', initials: 'DM', attempts: 12, pts: 920 },
  { rank: 3, name: 'Jordan (you)', initials: 'JM', attempts: 10, pts: 840, self: true },
]

export const rankStyles: Record<number, string> = {
  1: 'bg-volt text-black shadow-voltglow',
  2: 'bg-zinc-200 text-black',
  3: 'bg-[#C9A86A] text-black',
}
