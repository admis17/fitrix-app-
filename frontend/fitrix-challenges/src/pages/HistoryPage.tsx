import { useState } from 'react'
import { motion } from 'framer-motion'
import { Medal, TrendingUp } from 'lucide-react'
import SubPageLayout from '@/components/SubPageLayout'
import { Card } from '@/components/ui/card'
import { Badge } from '@/components/ui/badge'
import { cn } from '@/lib/utils'

const past = [
  { name: 'August Shred', meta: '18/20 workouts · Strength', pts: '+320 pts', rank: '#2 of 48', won: false },
  { name: 'July Cardio Cup', meta: '12/15 workouts · Cardio', pts: '+180 pts', rank: '#5 of 62', won: false },
  { name: 'June Flex Fest', meta: '15/15 workouts · Flex', pts: '+500 pts', rank: 'Winner 🏆', won: true },
]

const filters = ['All', 'Won', 'Completed']

export default function HistoryPage() {
  const [f, setF] = useState('All')
  const list = past.filter((p) => (f === 'All' ? true : f === 'Won' ? p.won : !p.won))

  return (
    <SubPageLayout title="History" subtitle="Your past challenges & earnings">
      <div className="grid grid-cols-3 gap-2">
        {[
          { k: 'Challenges', v: '12' },
          { k: 'Total pts', v: '1,840' },
          { k: 'Wins', v: '3' },
        ].map((s, i) => (
          <motion.div key={s.k} initial={{ opacity: 0, y: 12 }} animate={{ opacity: 1, y: 0 }} transition={{ delay: i * 0.07 }}>
            <Card className="p-3 text-center">
              <div className="text-[19px] font-black text-volt">{s.v}</div>
              <div className="mt-0.5 text-[10.5px] font-bold uppercase tracking-widest text-muted2">{s.k}</div>
            </Card>
          </motion.div>
        ))}
      </div>

      <div className="mt-4 flex gap-2">
        {filters.map((x) => (
          <button
            key={x}
            onClick={() => setF(x)}
            className={cn(
              'rounded-full border px-3.5 py-2 text-[12px] font-bold transition-all active:scale-95',
              f === x ? 'border-volt bg-volt text-black' : 'border-line bg-surface text-white'
            )}
          >
            {x}
          </button>
        ))}
      </div>

      <div className="mt-3 space-y-2.5">
        {list.map((p, i) => (
          <motion.div key={p.name} initial={{ opacity: 0, y: 12 }} animate={{ opacity: 1, y: 0 }} transition={{ delay: i * 0.08 }}>
            <Card className="flex items-center gap-3 p-3.5">
              <span className={cn('grid h-10 w-10 place-items-center rounded-xl border', p.won ? 'border-volt/30 bg-volt/10 text-volt' : 'border-line bg-surface2 text-muted2')}>
                {p.won ? <Medal size={18} /> : <TrendingUp size={18} />}
              </span>
              <span className="min-w-0 flex-1">
                <b className="block truncate text-[13.5px]">{p.name}</b>
                <span className="text-[12px] text-muted2">{p.meta}</span>
              </span>
              <span className="text-right">
                <b className="block text-[13px] text-volt">{p.pts}</b>
                <span className="text-[11px] text-muted2">{p.rank}</span>
              </span>
            </Card>
          </motion.div>
        ))}
        {list.length === 0 && (
          <Card className="p-6 text-center text-[13px] text-muted2">Nothing here yet.</Card>
        )}
      </div>

      <div className="mt-4 flex items-center justify-center gap-2">
        <Badge variant="join">● Streak safe</Badge>
        <Badge variant="rank">Best: 21 days</Badge>
      </div>
    </SubPageLayout>
  )
}
