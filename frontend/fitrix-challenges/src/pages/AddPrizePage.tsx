import { useState } from 'react'
import { motion } from 'framer-motion'
import { BadgeIndianRupee, CheckCircle2, Trophy, Wallet } from 'lucide-react'
import SubPageLayout from '@/components/SubPageLayout'
import { Card } from '@/components/ui/card'
import { Button } from '@/components/ui/button'
import { cn } from '@/lib/utils'

const amounts = [100, 500, 1000, 2500]

export default function AddPrizePage() {
  const [amt, setAmt] = useState(500)
  const [custom, setCustom] = useState('')
  const [method, setMethod] = useState('UPI')
  const [paid, setPaid] = useState(false)
  const total = custom ? Number(custom) || 0 : amt

  return (
    <SubPageLayout title="Add prize" subtitle="Boost the pool — motivates everyone">
      <motion.div initial={{ opacity: 0, y: 14 }} animate={{ opacity: 1, y: 0 }} transition={{ duration: 0.35 }}>
        <div className="rounded-2xl bg-gradient-to-br from-volt/50 via-volt/10 to-transparent p-[1.5px] shadow-voltglow">
          <div className="flex items-center justify-between rounded-2xl bg-surface px-4 py-4">
            <div className="flex items-center gap-3">
              <div className="grid h-[46px] w-[46px] place-items-center rounded-xl border border-volt/25 bg-volt/10 text-volt">
                <Trophy size={22} />
              </div>
              <div>
                <div className="text-[10px] font-bold uppercase tracking-[.08em] text-muted2">Total pool now</div>
                <div className="text-[11px] text-muted2">Set by gym &amp; participants</div>
              </div>
            </div>
            <div className="text-[26px] font-black tracking-tight text-volt">₹5,000</div>
          </div>
        </div>

        <Card className="mt-3 space-y-4 p-4">
          <div>
            <label className="mb-1.5 block text-[11px] font-bold uppercase tracking-widest text-muted2">Pick amount</label>
            <div className="grid grid-cols-4 gap-2">
              {amounts.map((a) => (
                <button
                  key={a}
                  onClick={() => { setAmt(a); setCustom('') }}
                  className={cn(
                    'rounded-xl border py-2.5 text-[13px] font-extrabold transition-all active:scale-95',
                    !custom && amt === a ? 'border-volt bg-volt text-black shadow-voltglow' : 'border-line bg-surface2 text-white'
                  )}
                >
                  ₹{a.toLocaleString('en-IN')}
                </button>
              ))}
            </div>
            <input
              value={custom}
              onChange={(e) => setCustom(e.target.value.replace(/[^0-9]/g, ''))}
              placeholder="Or custom amount in ₹"
              inputMode="numeric"
              className="mt-2 h-11 w-full rounded-xl border border-line bg-surface2 px-3 text-[13px] outline-none placeholder:text-muted2 focus:border-volt/50"
            />
          </div>

          <div>
            <label className="mb-1.5 block text-[11px] font-bold uppercase tracking-widest text-muted2">Pay with</label>
            <div className="grid grid-cols-2 gap-2">
              {['UPI', 'Card'].map((m) => (
                <button
                  key={m}
                  onClick={() => setMethod(m)}
                  className={cn(
                    'flex items-center justify-center gap-2 rounded-xl border py-2.5 text-[13px] font-bold transition-all active:scale-95',
                    method === m ? 'border-volt/50 bg-volt/10 text-volt' : 'border-line bg-surface2 text-white'
                  )}
                >
                  <Wallet size={14} /> {m}
                </button>
              ))}
            </div>
          </div>

          {!paid ? (
            <Button className="w-full" onClick={() => total > 0 && setPaid(true)}>
              <BadgeIndianRupee size={15} /> Contribute ₹{total.toLocaleString('en-IN')} via {method}
            </Button>
          ) : (
            <motion.div initial={{ scale: 0.96, opacity: 0 }} animate={{ scale: 1, opacity: 1 }} className="rounded-xl border border-volt/30 bg-volt/10 p-3.5 text-center">
              <CheckCircle2 size={22} className="mx-auto text-volt" />
              <b className="mt-1 block text-[14px]">Added ₹{total.toLocaleString('en-IN')}! 💚</b>
              <p className="mt-0.5 text-[12px] text-muted2">New pool ≈ ₹{(5000 + total).toLocaleString('en-IN')} · good karma unlocked</p>
            </motion.div>
          )}
          <p className="text-center text-[11px] text-muted2">100% goes to winners · UPI refunds in 24h if cancelled</p>
        </Card>
      </motion.div>
    </SubPageLayout>
  )
}
