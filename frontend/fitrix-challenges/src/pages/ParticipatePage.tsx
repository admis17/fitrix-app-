import { useState } from 'react'
import { motion } from 'framer-motion'
import { CheckCircle2, Flame, Gift, QrCode, Play, Sparkles } from 'lucide-react'
import SubPageLayout from '@/components/SubPageLayout'
import { Card } from '@/components/ui/card'
import { Badge } from '@/components/ui/badge'
import { Button } from '@/components/ui/button'

const steps = [
  { icon: QrCode, title: 'Check in at entry', desc: 'Scan barcode / Face / Bio' },
  { icon: Flame, title: 'Log 20 workouts', desc: 'Any category counts this month' },
  { icon: Gift, title: 'Unlock rewards', desc: 'Merch drop + 500 pts to wallet' },
]

export default function ParticipatePage() {
  const [done, setDone] = useState(false)
  return (
    <SubPageLayout title="Participate" subtitle="September Sweat · Strength · 3 spots left today">
      <motion.div initial={{ opacity: 0, y: 14 }} animate={{ opacity: 1, y: 0 }} transition={{ duration: 0.35 }}>
        <Card className="overflow-hidden p-0">
          <div className="relative h-[170px]">
            <img
              src="https://images.unsplash.com/photo-1517836357463-d25dfeac3438?w=1000&q=70&auto=format&fit=crop"
              alt="September Sweat"
              loading="lazy"
              className="h-full w-full object-cover"
            />
            <div className="absolute inset-0 bg-gradient-to-t from-black/75 via-black/20 to-transparent" />
            <button className="absolute left-1/2 top-1/2 grid h-[52px] w-[52px] -translate-x-1/2 -translate-y-1/2 place-items-center rounded-full border border-white/30 bg-white/15 backdrop-blur-xl" aria-label="Play">
              <Play size={20} className="ml-0.5 fill-white text-white" />
            </button>
            <div className="absolute inset-x-3 bottom-3 flex items-end justify-between">
              <div>
                <div className="text-[17px] font-black tracking-tight">September Sweat Challenge</div>
                <div className="mt-1 flex gap-1.5">
                  <Badge variant="join" pulse>● Live</Badge>
                  <Badge variant="rank">Strength</Badge>
                </div>
              </div>
              <span className="rounded-md bg-black/65 px-1.5 py-1 text-[10.5px] font-semibold">0:30</span>
            </div>
          </div>
          <div className="space-y-2.5 p-4">
            {steps.map((s, i) => (
              <motion.div
                key={s.title}
                initial={{ opacity: 0, x: -10 }}
                animate={{ opacity: 1, x: 0 }}
                transition={{ delay: 0.1 + i * 0.08 }}
                className="flex items-center gap-3 rounded-xl border border-line bg-surface2/60 px-3 py-2.5"
              >
                <span className="grid h-9 w-9 shrink-0 place-items-center rounded-xl bg-volt/10 text-volt"><s.icon size={17} /></span>
                <span><b className="block text-[13px]">{i + 1}. {s.title}</b><span className="text-[12px] text-muted2">{s.desc}</span></span>
              </motion.div>
            ))}
            {!done ? (
              <Button className="w-full" onClick={() => setDone(true)}>
                <Sparkles size={15} /> Confirm &amp; join — free
              </Button>
            ) : (
              <motion.div initial={{ scale: 0.96, opacity: 0 }} animate={{ scale: 1, opacity: 1 }} className="rounded-xl border border-volt/30 bg-volt/10 p-3.5 text-center">
                <CheckCircle2 size={22} className="mx-auto text-volt" />
                <b className="mt-1 block text-[14px]">You&apos;re in! 🎉</b>
                <p className="mt-0.5 text-[12px] text-muted2">Show this at entry today · 6:30 PM HIIT Circuit</p>
              </motion.div>
            )}
            <p className="text-center text-[11px] text-muted2">12 joined today · Prize pool ₹5,000</p>
          </div>
        </Card>
      </motion.div>
    </SubPageLayout>
  )
}
