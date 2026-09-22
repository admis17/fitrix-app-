import { useState } from 'react'
import { motion } from 'framer-motion'
import { CheckCircle2, Plus } from 'lucide-react'
import SubPageLayout from '@/components/SubPageLayout'
import { Card } from '@/components/ui/card'
import { Button } from '@/components/ui/button'
import { cn } from '@/lib/utils'

const cats = ['Strength', 'Cardio', 'Yoga', 'Flex']
const covers = [
  'from-[#1B2600] via-[#243600] to-[#0F1400]',
  'from-[#2A0E00] via-[#3A1A00] to-[#140A00]',
  'from-[#001A26] via-[#002A3A] to-[#000F14]',
  'from-[#26001B] via-[#36002A] to-[#14000F]',
]

export default function AddChallengePage() {
  const [cat, setCat] = useState('Strength')
  const [cover, setCover] = useState(0)
  const [name, setName] = useState('')
  const [created, setCreated] = useState(false)

  return (
    <SubPageLayout title="Add challenge" subtitle="Create a new challenge for your club">
      <motion.div initial={{ opacity: 0, y: 14 }} animate={{ opacity: 1, y: 0 }} transition={{ duration: 0.35 }}>
        <Card className="space-y-4 p-4">
          <div className={cn('relative h-[130px] overflow-hidden rounded-xl bg-gradient-to-br', covers[cover])}>
            <div className="absolute inset-0 bg-gradient-to-t from-black/60 to-transparent" />
            <div className="absolute bottom-2.5 left-3 right-3 flex items-end justify-between">
              <b className="text-[15px] font-black">{name || 'Your challenge name'}</b>
              <span className="rounded-full bg-volt px-2 py-0.5 text-[10px] font-extrabold text-black">{cat}</span>
            </div>
          </div>

          <div>
            <label className="mb-1.5 block text-[11px] font-bold uppercase tracking-widest text-muted2">Challenge name</label>
            <input
              value={name}
              onChange={(e) => setName(e.target.value)}
              placeholder="e.g. Morning Burn 5K"
              className="h-11 w-full rounded-xl border border-line bg-surface2 px-3 text-[13.5px] outline-none placeholder:text-muted2 focus:border-volt/50"
            />
          </div>

          <div>
            <label className="mb-1.5 block text-[11px] font-bold uppercase tracking-widest text-muted2">Category</label>
            <div className="flex flex-wrap gap-2">
              {cats.map((c) => (
                <button
                  key={c}
                  onClick={() => setCat(c)}
                  className={cn(
                    'rounded-full border px-3.5 py-2 text-[12.5px] font-bold transition-all active:scale-95',
                    cat === c ? 'border-volt bg-volt text-black shadow-voltglow' : 'border-line bg-surface2 text-white hover:border-[#3A4047]'
                  )}
                >
                  {cat === c ? `✓ ${c}` : c}
                </button>
              ))}
            </div>
          </div>

          <div className="grid grid-cols-2 gap-2">
            <div>
              <label className="mb-1.5 block text-[11px] font-bold uppercase tracking-widest text-muted2">Time</label>
              <input placeholder="6:30 PM" className="h-11 w-full rounded-xl border border-line bg-surface2 px-3 text-[13px] outline-none placeholder:text-muted2 focus:border-volt/50" />
            </div>
            <div>
              <label className="mb-1.5 block text-[11px] font-bold uppercase tracking-widest text-muted2">Coach</label>
              <input placeholder="Coach Rae" className="h-11 w-full rounded-xl border border-line bg-surface2 px-3 text-[13px] outline-none placeholder:text-muted2 focus:border-volt/50" />
            </div>
          </div>

          <div>
            <label className="mb-1.5 block text-[11px] font-bold uppercase tracking-widest text-muted2">Cover vibe</label>
            <div className="grid grid-cols-4 gap-2">
              {covers.map((g, i) => (
                <button
                  key={g}
                  onClick={() => setCover(i)}
                  className={cn('h-12 rounded-xl bg-gradient-to-br transition-all active:scale-95', g, cover === i ? 'ring-2 ring-volt ring-offset-2 ring-offset-surface' : 'opacity-70 hover:opacity-100')}
                  aria-label={`Cover ${i + 1}`}
                />
              ))}
            </div>
          </div>

          {!created ? (
            <Button className="w-full" onClick={() => setCreated(true)}><Plus size={15} /> Create challenge</Button>
          ) : (
            <motion.div initial={{ scale: 0.96, opacity: 0 }} animate={{ scale: 1, opacity: 1 }} className="rounded-xl border border-volt/30 bg-volt/10 p-3.5 text-center">
              <CheckCircle2 size={22} className="mx-auto text-volt" />
              <b className="mt-1 block text-[14px]">Challenge live! 🚀</b>
              <p className="mt-0.5 text-[12px] text-muted2">{name || 'Morning Burn'} · {cat} · visible on Challenges</p>
            </motion.div>
          )}
        </Card>
      </motion.div>
    </SubPageLayout>
  )
}
