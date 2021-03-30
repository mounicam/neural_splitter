import glob, re
import argparse


def get_output_sentences(file_name, interactive=5, lines_to_ignore=5):
    if interactive == 4:
        lines = open(file_name).readlines()[lines_to_ignore:]
    else:
        lines = open(file_name).readlines()[lines_to_ignore:-2]

    i = 0
    preds = {}
    while i < len(lines):

        token = lines[i].split()[0]
        number = int(token.split("-")[1])

        hyp = lines[i + (interactive - 3)].split("\t")[2].strip()
        alignments = lines[i + (interactive - 1)].split("\t")[1].strip()
        alignments = [int(a.split("-")[0]) for a in alignments.split()]

        preds[number] = (hyp, alignments)
        i = i + interactive

    return preds


def main(args):

    out_anon_sents = get_output_sentences(args.out_anon, int(args.interactive), int(args.ignore_lines))

    fp = open(args.denon, "w")

    for i in range(0, len(out_anon_sents)):
        hyp, _ = out_anon_sents[i]
        denon_sent = hyp.replace("[SEP]", "<SEP>").strip()

        if denon_sent.endswith("<SEP>"):
            denon_sent = " ".join(denon_sent.split()[1:-1])
        else:
            denon_sent = " ".join(denon_sent.split()[1:])

        denon_sent = denon_sent.replace(" ##", "").strip()
        denon_sent = " ".join([tok for tok in denon_sent.split() if "[unused1]" not in tok])

        fp.write(denon_sent + "\n")

    fp.close()


if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('--out_anon')
    parser.add_argument('--denon')
    parser.add_argument('--ignore_lines', default=5)
    parser.add_argument('--interactive', default=5)
    args = parser.parse_args()
    main(args)
