import { Link } from 'react-router-dom'
import { motion } from 'framer-motion'
import { ArrowLeft, Trophy } from 'lucide-react'
import type { ReactNode } from 'react'

export default function SubPageLayout({
  title,
  subtitle,
  children,
}: {
  title: string
  subtitle: string
  children: ReactNode
}) {
  return (
    <div className="min-h-full bg-ink text-white">
      <header className="sticky top-0 z-30 border-b border-line bg-ink/80 backdrop-blur-xl">
        <div className="mx-auto flex max-w-[680px] items-center gap-3 px-4 py-3">
          <Link
            to="/"
            className="grid h-9 w-9 place-items-center rounded-full border border-line bg-surface transition-colors hover:border-volt/40 hover:bg-surface2"
            aria-label="Back to Challenges"
          >
            <ArrowLeft size={17} />
          </Link>
          <div className="flex items-center gap-2">
            <div className="grid h-8 w-8 place-items-center rounded-[10px] bg-volt text-[15px] font-black text-black">F</div>
            <div className="text-[16px] font-black tracking-tight">
              FIT<span className="text-volt">RIX</span>
              <span className="ml-2 align-middle text-[10px] font-bold uppercase tracking-widest text-muted2">· Challenges</span>
            </div>
          </div>
          <div className="ml-auto grid h-9 w-9 place-items-center rounded-full border border-volt/25 bg-volt/10 text-volt">
            <Trophy size={15} />
          </div>
        </div>
      </header>

      <main className="mx-auto max-w-[680px] px-4 pb-12 pt-5">
        <motion.div initial={{ opacity: 0, y: 14 }} animate={{ opacity: 1, y: 0 }} transition={{ duration: 0.35, ease: [0.22, 1, 0.36, 1] }}>
          <h1 className="text-[24px] font-black leading-none tracking-tight">{title}</h1>
          <p className="mt-1.5 text-[12.5px] text-muted2">{subtitle}</p>
        </motion.div>
        <div className="mt-5">{children}</div>
        <Link
          to="/"
          className="mt-6 flex items-center justify-center gap-2 rounded-xl border border-line bg-surface py-3 text-[13px] font-bold text-muted2 transition-colors hover:border-volt/40 hover:text-white"
        >
          <ArrowLeft size={15} /> Back to Challenges
        </Link>
        <p className="mt-3 text-center text-[11px] text-muted2">Only linked to Challenges — no other tabs</p>
      </main>
    </div>
  )
}
